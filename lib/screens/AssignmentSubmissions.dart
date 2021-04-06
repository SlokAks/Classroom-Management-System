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

  Widget title() {
    return Container(
      margin: const EdgeInsets.all(10.0),
      height: 60,
      child: Card(
        color: Colors.blue,
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  Text(
                    'EMAIL',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              VerticalDivider(
                thickness: 2,
                width: 20,
                color: Colors.black,
              ),
              Row(
                children: [
                  Icon(
                    Icons.perm_identity_outlined,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  Text(
                    'STUDENT NAME',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              VerticalDivider(
                thickness: 2,
                width: 20,
                color: Colors.black,
              ),
              Row(
                children: [
                  Icon(
                    Icons.work,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  Text(
                    'WORK',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              VerticalDivider(
                thickness: 2,
                width: 20,
                color: Colors.black,
              ),
              Row(
                children: [
                  Icon(
                    Icons.grade,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  Text(
                    'Grade',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    studentsList.add(title());
    FirebaseFirestore.instance
        .collection("Courses")
        .doc(courseId)
        .collection("enrolledStudents")
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
                    } else {
                      setState(() {
                        studentsList.add(AssignmentSubmissionsTile(
                            user.id, "", "", courseId, assignmentId));
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
