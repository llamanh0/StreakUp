import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart'; // We haven't added this package but can use simple random string or DateTime
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    Task(id: '1', title: 'Calculus Finaline Çalış', isCompleted: false),
    Task(id: '2', title: 'Flutter Projesini Bitir', isCompleted: true),
    Task(id: '3', title: 'Bulaşıkları Yıka', isCompleted: false),
  ];

  // Getters
  List<Task> get personalTasks =>
      _tasks.where((t) => t.groupId == null).toList();
  List<Task> get groupTasks => _tasks.where((t) => t.groupId != null).toList();

  void addTask(String title, {String? groupId}) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch
          .toString(), // Simple ID generation
      title: title,
      groupId: groupId,
    );
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTask(String taskId) {
    final index = _tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
      );
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((t) => t.id == taskId);
    notifyListeners();
  }
}
