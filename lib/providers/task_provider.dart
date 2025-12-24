import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';
import '../services/auth_service.dart';

/// Manages the state of user tasks (both personal and group).
///
/// This provider handles:
/// - Fetching tasks from Firestore.
/// - Optimistic updates for task completion (toggling).
/// - Creating and deleting tasks.
class TaskProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Auth State from ProxyProvider
  String? _userId;

  List<Task> _tasks = [];
  bool _isLoading = false;

  // -- Getters --
  bool get isLoading => _isLoading;

  List<Task> get personalTasks =>
      _tasks.where((t) => t.groupId == null).toList();

  List<Task> get groupTasks => _tasks.where((t) => t.groupId != null).toList();

  // -- Update Method for ProxyProvider --
  void update(AuthService auth) {
    final newUserId = auth.currentUser?.uid;

    if (_userId != newUserId) {
      _userId = newUserId;
      _tasks = []; // Clear tasks on user switch/logout

      if (_userId != null) {
        fetchTasks();
      } else {
        notifyListeners();
      }
    }
  }

  // -- Actions --

  /// Fetch tasks associated with the current user.
  Future<void> fetchTasks() async {
    if (_userId == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // 1. Fetch Personal Tasks
      // Using snapshots for real-time updates (Consistency Improvement)
      _firestore
          .collection('tasks')
          .where('createdBy', isEqualTo: _userId)
          .where('groupId', isNull: true)
          .snapshots()
          .listen(
            (snapshot) {
              final List<Task> loadedTasks = [];
              for (var doc in snapshot.docs) {
                loadedTasks.add(Task.fromMap(doc.data(), doc.id));
              }
              _tasks = loadedTasks;
              _isLoading = false;
              notifyListeners();
            },
            onError: (e) {
              debugPrint("Error listening to tasks: $e");
              _isLoading = false;
              notifyListeners();
            },
          );

      // TODO: Add listeners for Group Tasks if needed separately.
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds a new task to Firestore and updates local state.
  Future<void> addTask(String title, {String? groupId}) async {
    if (_userId == null) return;

    final newTaskLog = {
      'title': title,
      'isCompleted': false,
      'createdBy': _userId,
      'groupId': groupId,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      await _firestore.collection('tasks').add(newTaskLog);
      // No need to manually add to _tasks list if we use snapshots()
    } catch (e) {
      debugPrint("Error adding task: $e");
    }
  }

  /// Toggles the completion status of a task.
  Future<void> toggleTask(String taskId) async {
    if (_userId == null) return;

    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      final currentStatus = _tasks[index].isCompleted;

      // Optimistic update
      _tasks[index] = _tasks[index].copyWith(isCompleted: !currentStatus);
      notifyListeners();

      try {
        await _firestore.collection('tasks').doc(taskId).update({
          'isCompleted': !currentStatus,
        });
      } catch (e) {
        // Revert on failure
        _tasks[index] = _tasks[index].copyWith(isCompleted: currentStatus);
        notifyListeners();
        debugPrint("Error toggling task: $e");
      }
    }
  }

  /// Deletes a task.
  Future<void> deleteTask(String taskId) async {
    if (_userId == null) return;

    final existingTaskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (existingTaskIndex == -1) return;

    // Optimistic remove
    final existingTask = _tasks[existingTaskIndex];
    _tasks.removeAt(existingTaskIndex);
    notifyListeners();

    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      // Revert on failure
      _tasks.insert(existingTaskIndex, existingTask);
      notifyListeners();
      debugPrint("Error deleting task: $e");
    }
  }
}
