import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  final String id;
  final String title;
  final String description;
  final String link;
  final Timestamp dueDate;
  Assignment({
    this.id,
    this.title,
    this.description,
    this.link,
    this.dueDate
  });

  factory Assignment.fromDocument(DocumentSnapshot doc) {
    return Assignment(
        id: doc.id,
        description: doc['description'],
        title: doc['title'],
      link: doc['link'],
      dueDate: doc['dueDate']
    );
  }
}