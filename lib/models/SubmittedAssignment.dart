import 'package:cloud_firestore/cloud_firestore.dart';

class SubmittedAssignment {
  final String id;
  final String fileName;
  final String grade;
  final String url;
  final Timestamp submittedAt;
  SubmittedAssignment({
    this.id,
    this.fileName,
    this.grade,
    this.url,
    this.submittedAt
  });

  factory SubmittedAssignment.fromDocument(DocumentSnapshot doc) {
    return SubmittedAssignment(
        id: doc.id,
        fileName: doc['fileName'],
        grade: doc['grade'],
        url: doc['url'],
        submittedAt: doc['submittedAt']
    );
  }
}