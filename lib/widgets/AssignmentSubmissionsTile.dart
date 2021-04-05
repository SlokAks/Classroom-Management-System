import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
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

    return Container(
      child: Row(
        children: <Widget>[
          Expanded(flex: 1, child: Text(studentId)),
          (() {
            if (workSubmitted.isEmpty)
              return Expanded(flex: 1, child: Text('Not Submitted'));
            else
              return Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () {
                            window.open(this.workSubmitted, 'new tab');
                          },
                          child: Text('View Work')),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _gradeTextFieldController,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: () {
                            String grade = _gradeTextFieldController.text;
//TODO: check if assignment is submitted
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(studentId)
                                .collection("enrolledCourses")
                                .doc(courseId)
                                .collection("Assignments")
                                .doc(assignmentId)
                                .update({'grade': grade});
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Graded')));
                          },
                          child: Text('Grade')),
                    )
                  ],
                ),
              );
          }()),
        ],
      ),
    );
  }
}
