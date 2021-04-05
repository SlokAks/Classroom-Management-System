import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssignmentSubmissionsTile extends StatelessWidget {
  String studentId, workSubmitted, gradeGiven, courseId, assignmentId;

  AssignmentSubmissionsTile(this.studentId, this.workSubmitted, this.gradeGiven,
      this.courseId, this.assignmentId);

  @override
  Widget build(BuildContext context) {
    TextEditingController _gradeTextFieldController = new TextEditingController(
        text: gradeGiven.isEmpty ? "Not Graded" : gradeGiven);

    if (gradeGiven.isEmpty)
      return Container(
        child: Row(
          children: <Widget>[
            Expanded(child: Text(studentId)),
            Expanded(
                child: (() {
              if (workSubmitted.isEmpty)
                return Text('Not Submitted');
              else
                return ElevatedButton(
                    onPressed: () {
                      window.open(this.workSubmitted, 'new tab');
                    },
                    child: Text('View Work'));
            }())),
            Expanded(
                child: Row(
              children: <Widget>[
                TextField(
                  controller: _gradeTextFieldController,
                ),
                ElevatedButton(
                    onPressed: () {
                      String grade = _gradeTextFieldController.text;
//TODO: check if assignment is submitted
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection("enrolledCourses")
                          .doc(courseId)
                          .collection("Assignments")
                          .doc(assignmentId)
                          .update({'grade': gradeGiven}).then((value) => () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Graded')));
                              });
                    },
                    child: Text('Grade'))
              ],
            ))
          ],
        ),
      );
  }
}
