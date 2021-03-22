import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser {
  final String id;
  final String name;
  final String email;
  final String contact;
  final bool isProf;
  CurrentUser({
    this.id,
    this.name,
    this.email,
    this.contact,
    this.isProf
  });

  factory CurrentUser.fromDocument(DocumentSnapshot doc) {
    return CurrentUser(
      id: doc.id,
      email: doc['email'],
      name: doc['name'],
      contact: doc['contact'],
      isProf: doc['isProf'],
    );
  }
}