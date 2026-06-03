import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current User ID get karne ke liye helper getter
  String get uid => _auth.currentUser?.uid ?? '';

  // Task Subcollection Reference
  CollectionReference get _taskCollection {
    if (uid.isEmpty) throw Exception("User not authenticated");
    return _db.collection('users').doc(uid).collection('tasks');
  }

  // 1. CREATE: Naya Task add karna
  Future<void> addTask(String title, String description, DateTime dueDate) async {
    final newTask = TaskModel(
      id: '', // Firestore auto-generate karega
      title: title,
      description: description,
      dueDate: dueDate,
    );
    await _taskCollection.add(newTask.toMap());
  }

  // 2. READ: Real-time Tasks Ka Stream (Automatic updates UI mein)
  Stream<List<TaskModel>> get streamTasks {
    return _taskCollection
        .orderBy('dueDate', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // 3. UPDATE: Task Status toggle karna (Complete/Incomplete)
  Future<void> toggleTaskStatus(String taskId, bool currentStatus) async {
    await _taskCollection.doc(taskId).update({
      'isCompleted': !currentStatus,
    });
  }

  // 4. DELETE: Task delete karna
  Future<void> deleteTask(String taskId) async {
    await _taskCollection.doc(taskId).delete();
  }
}