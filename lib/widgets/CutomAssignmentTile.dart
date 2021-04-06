import 'dart:html' as html;

import 'package:classroom_management/screens/AssignmentSubmissions.dart';
import 'package:classroom_management/screens/AssignmentView.dart';
import 'package:classroom_management/screens/EditAssignment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAssignmentListTile extends StatelessWidget {
  Widget widget;
  String courseId;
  String title;
  String description;
  String url;
  Timestamp dueDate;
  String assignmentId;
  bool isProf = false;
  CustomAssignmentListTile(
      {this.courseId,
      this.title,
      this.description,
      this.dueDate,
      this.url,
      this.assignmentId,
      this.isProf});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 14.0,
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),

                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Colors.grey[700], Colors.white])),

                // color: Colors.grey[600],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title == null ? "" : title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      "Due Date : " + dueDate.toDate().toString(),
                      style: TextStyle(
                        color: Colors.red[900],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.grey[100],
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      description == null ? "" : description,
                      textAlign: TextAlign.left,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Download Assignment "),
                    SizedBox(
                      height: 20.0,
                    ),
                    IconButton(
                        onPressed: () {
                          html.window.open(url, 'new tab');
                        },
                        icon: Icon(Icons.assignment)),
                    (() {
                      if (!isProf)
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AssignmentView(
                                        title: this.title,
                                        description: this.description,
                                        courseId: this.courseId,
                                        assignmentId: this.assignmentId,
                                        dueDate: dueDate,
                                        url: this.url)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Go to Assignment"),
                          ),
                        );
                      else
                        return Container();
                    }()),
                    SizedBox(
                      width: 20.0,
                    ),
                    isProf
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditAssignment(
                                                courseId: courseId,
                                                AssignmentId: assignmentId,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Edit Assignment"),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AssignmentSubmissions(
                                                courseId,
                                                assignmentId,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("View Submissions"),
                                ),
                              )
                            ],
                          )
                        : Container()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
