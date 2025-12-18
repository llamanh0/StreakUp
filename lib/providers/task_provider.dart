import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get personalTasks =>
      _tasks.where((t) => t.groupId == null).toList();
  List<Task> get groupTasks => _tasks.where((t) => t.groupId != null).toList();
  bool get isLoading => _isLoading;

  // Fetch tasks from Firestore
  Future<void> fetchTasks() async {
    final user = _auth.currentUser;
    if (user == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      // 1. Get Personal Tasks
      final personalSnapshot = await _firestore
          .collection('tasks')
          .where('createdBy', isEqualTo: user.uid)
          .where('groupId', isNull: true)
          .get();

      final List<Task> loadedTasks = [];

      for (var doc in personalSnapshot.docs) {
        loadedTasks.add(Task.fromMap(doc.data(), doc.id));
      }

      // TODO: Fetch group tasks separately or efficiently

      _tasks = loadedTasks;
    } catch (e) {
      debugPrint("Error fetching tasks: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTask(String title, {String? groupId}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final newTaskLog = {
      'title': title,
      'isCompleted': false,
      'createdBy': user.uid,
      'groupId': groupId,
      'createdAt': FieldValue.serverTimestamp(),
    };

    try {
      final docRef = await _firestore.collection('tasks').add(newTaskLog);

      final newTask = Task(
        id: docRef.id,
        title: title,
        isCompleted: false,
        groupId: groupId,
      );

      _tasks.add(newTask);
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding task: $e");
    }
  }

  Future<void> toggleTask(String taskId) async {
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
        // Revert if failed
        _tasks[index] = _tasks[index].copyWith(isCompleted: currentStatus);
        notifyListeners();
        debugPrint("Error toggling task: $e");
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    // Optimistic remove
    final existingTaskIndex = _tasks.indexWhere((t) => t.id == taskId);
    if (existingTaskIndex == -1) return;

    final existingTask = _tasks[existingTaskIndex];
    _tasks.removeAt(existingTaskIndex);
    notifyListeners();

    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      // Revert
      _tasks.insert(existingTaskIndex, existingTask);
      notifyListeners();
      debugPrint("Error deleting task: $e");
    }
  }
}
