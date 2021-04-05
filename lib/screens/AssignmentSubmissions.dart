import 'package:classroom_management/widgets/AssignmentSubmissionsTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AssignmentSubmissions extends StatefulWidget {
  String assignmentId, courseId;
  AssignmentSubmissions(this.courseId, this.assignmentId);

  @override
  _AssignmentSubmissionsState createState() =>
      _AssignmentSubmissionsState(courseId, assignmentId);
}

class _AssignmentSubmissionsState extends State<AssignmentSubmissions> {
  String assignmentId, courseId;
  _AssignmentSubmissionsState(this.courseId, this.assignmentId);

  List<Widget> studentsList = new List();

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((usersSnapshot) => usersSnapshot.docs.forEach((user) {
              print(user.id);
              print(courseId);
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(user.id)
                  .collection("enrolledCourses")
                  .doc(courseId)
                  .get()
                  .then((courseSnapshot) {
                if (courseSnapshot.exists) {
                  courseSnapshot.reference
                      .collection("Assignments")
                      .doc(assignmentId)
                      .get()
                      .then((assignment) {
                    if (assignment.exists) {
                      setState(() {
                        studentsList.add(AssignmentSubmissionsTile(
                            user.id,
                            assignment['url'],
                            assignment['grade'],
                            courseId,
                            assignmentId));
                      });
                    }
                  });
                }
              });
            }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Students Work for assignment " + assignmentId,
      ).build(context),
      body: Column(
        children: studentsList,
      ),
    );
  }
}
