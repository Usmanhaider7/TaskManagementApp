import 'dart:async';
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/database_service.dart';

class TaskProvider with ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  List<TaskModel> _tasks = [];
  StreamSubscription<List<TaskModel>>? _tasksSubscription;
  bool _isLoading = true;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;

  TaskProvider() {
    _fetchTasks();
  }

  // Listen to real-time updates from Firestore
  void _fetchTasks() {
    _isLoading = true;
    notifyListeners();

    _tasksSubscription?.cancel();
    _tasksSubscription = _dbService.streamTasks.listen((taskList) {
      _tasks = taskList;
      _isLoading = false;
      notifyListeners();
    }, onError: (error) {
      debugPrint("Error fetching tasks: $error");
      _isLoading = false;
      notifyListeners();
    });
  }

  // Add Task
  Future<void> addTask(String title, String description, DateTime dueDate) async {
    await _dbService.addTask(title, description, dueDate);
  }

  // Toggle Task Status
  Future<void> toggleTaskStatus(String taskId, bool currentStatus) async {
    await _dbService.toggleTaskStatus(taskId, currentStatus);
  }

  // Delete Task
  Future<void> deleteTask(String taskId) async {
    await _dbService.deleteTask(taskId);
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }
}
