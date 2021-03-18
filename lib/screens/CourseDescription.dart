import 'package:classroom_management/widgets/appbar.dart';
import 'package:flutter/material.dart';

class CourseDescription extends StatelessWidget {

  String title = "Software Engineering";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text("Course Description",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 44.0
            ),),
          ),
          Divider(),
          Container(
            height: 550.0,
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
            child: Column(
              children: [
                Text("Name of the Course :    Software Engineering",style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 28.0,
                ),),
                Text("LTP structure of the course:    2-1-1",style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 28.0,
                ),),
                Text("Objective of the course: Apply software engineering theory, principles, tools and processes",style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 28.0,
                ),),
              ],
            ),
          )
        ],
      ),

    );
  }
}
