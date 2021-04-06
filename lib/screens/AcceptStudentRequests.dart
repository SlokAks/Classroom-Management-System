import 'package:classroom_management/widgets/verifyCourseTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptStudentRequests extends StatefulWidget {
  String courseId = "";
  AcceptStudentRequests({this.courseId});
  @override
  _AcceptStudentRequestsState createState() => _AcceptStudentRequestsState();
}

class _AcceptStudentRequestsState extends State<AcceptStudentRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Requests"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Courses")
            .doc(widget.courseId)
            .collection("pendingRequests")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error Occured in fetching details.."),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data.docs.map((document) {
              return VerifyCourseTile(
                courseId: widget.courseId,
                email: document['email'],
                uid: document['uid'],
                name: document['name'],
              );
            }).toList());
          }
        },
      ),
    );
  }
}
