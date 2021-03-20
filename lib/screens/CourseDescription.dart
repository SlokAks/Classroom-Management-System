import 'package:flutter/material.dart';

class CourseDescription extends StatelessWidget {
  String title = "NA";
  String description = "NA";
  CourseDescription({this.title, this.description});
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
          )
        ],
      ),
    );
  }
}
