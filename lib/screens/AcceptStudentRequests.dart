import 'package:flutter/material.dart';

class AcceptStudentRequests extends StatefulWidget {
  String courseId="";
  AcceptStudentRequests({this.courseId});
  @override
  _AcceptStudentRequestsState createState() => _AcceptStudentRequestsState();
}

class _AcceptStudentRequestsState extends State<AcceptStudentRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending Requests"),
        actions: [
          FlatButton(
            textColor: Colors.white,
            onPressed: () {

            },
            child: Text("Manually Add a Student",style: TextStyle(
                fontSize: 22
            ),),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),

    );
  }
}
