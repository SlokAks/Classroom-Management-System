import 'package:classroom_management/screens/course.dart';
import 'package:flutter/material.dart';

import 'Announcements.dart';

class CourseDescription extends StatelessWidget {
  String courseId;
  String title = "NA";
  String description = "NA";
  CourseDescription(this.courseId, {this.title, this.description});
  @override
  Widget build(BuildContext context) {
    print(courseId);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              "Course Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 44.0),
            ),
          ),
          Divider(),
          Container(
            height: 550.0,
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
            child: Column(
              children: [
                Text(
                  "Name of the Course :    " + title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 28.0,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 28.0,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Course(courseId,title: title,description: description,)),
              );
            },
            child: Container(
              height: 130.0,
              width: 450.0,
              child: Card(
                elevation: 14.0,
                child: Container(
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: Center(
                    child: Text(
                      "Go to Course Page",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
