import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnrolledCoursesTile extends StatelessWidget {
  String courseName, courseInstructor, courseDescription;

  EnrolledCoursesTile(
      this.courseName, this.courseInstructor, this.courseDescription);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        Text(courseName),
        Text(courseInstructor),
        Text(courseDescription),
      ]),
    );
  }
}
