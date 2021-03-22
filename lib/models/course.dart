import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String id;
  final String name;
  final String description;
  Course({
    this.id,
    this.name,
    this.description
  });

  factory Course.fromDocument(DocumentSnapshot doc) {
    return Course(
      id: doc.id,
      description: doc['description'],
      name: doc['name']
    );
  }
}