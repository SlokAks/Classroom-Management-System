import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class AssignmentSubmissionsTile extends StatelessWidget {
//
// }

class AssignmentSubmissionsTile extends StatefulWidget {
  String studentId, workSubmitted, gradeGiven, courseId, assignmentId;

  AssignmentSubmissionsTile(this.studentId, this.workSubmitted, this.gradeGiven,
      this.courseId, this.assignmentId);

  @override
  _AssignmentSubmissionsTileState createState() =>
      _AssignmentSubmissionsTileState(
          studentId, workSubmitted, gradeGiven, courseId, assignmentId);
}

class _AssignmentSubmissionsTileState extends State<AssignmentSubmissionsTile> {
  String studentId,
      workSubmitted,
      gradeGiven,
      courseId,
      assignmentId,
      studentEmail = "NA",
      studentName = "NA";

  _AssignmentSubmissionsTileState(this.studentId, this.workSubmitted,
      this.gradeGiven, this.courseId, this.assignmentId);

  Widget workWidget, gradeWidget;

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(studentId)
        .get()
        .then((student) {
      setState(() {
        studentEmail = student['email'];
        studentName = student['name'];
      });
    });

    TextEditingController _gradeTextFieldController = new TextEditingController(
        text: gradeGiven.isEmpty ? "Not Graded" : gradeGiven);

    if (workSubmitted.isEmpty) {
      workWidget = Expanded(
          child: Text(
        'Not Submitted',
        textAlign: TextAlign.center,
      ));
      gradeWidget = Expanded(
          child: Text(
        'Cant Grade',
        textAlign: TextAlign.center,
      ));
    } else {
      workWidget = Expanded(
        child: ElevatedButton(
          onPressed: () {
            window.open(this.workSubmitted, 'new tab');
          },
          child: Text(
            'View Work',
            textAlign: TextAlign.center,
          ),
        ),
      );
      gradeWidget = Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Flexible(
              child: SizedBox(
                width: 300,
                child: TextFormField(
                  controller: _gradeTextFieldController,
                ),
              ),
            ),
            ButtonTheme(
              minWidth: 200,
              height: 40,
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
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Graded')));
                  },
                  child: Text('Grade')),
            )
          ],
        ),
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.lightBlueAccent,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Text(
                studentEmail,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            VerticalDivider(
              thickness: 2,
              width: 20,
              color: Colors.black,
            ),
            Expanded(
              child: Text(
                studentName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            VerticalDivider(
              thickness: 2,
              width: 20,
              color: Colors.black,
            ),
            workWidget,
            VerticalDivider(
              thickness: 2,
              width: 20,
              color: Colors.black,
            ),
            gradeWidget
          ],
        ),
      ),
    );
  }
}
