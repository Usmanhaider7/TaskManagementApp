import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String description;
  bool isCompleted;
  DateTime dueDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.dueDate,
  });

  // Firestore Document se Data nikal kar model banane ke liye
  factory TaskModel.fromMap(Map<String, dynamic> map, String documentId) {
    return TaskModel(
      id: documentId,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      dueDate: (map['dueDate'] as Timestamp).toDate(),
    );
  }

  // Model ko Firestore mein save karne ke liye Map mein convert karna
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'dueDate': Timestamp.fromDate(dueDate),
    };
  }
}