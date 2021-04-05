import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerifyCourseTile extends StatelessWidget {
  String uid;
  String name;
  String email;
  String courseId;
  List<Color> randcolor = [
    Colors.red[500],
    Colors.green[500],
    Colors.blue[500],
    Colors.yellow[500],
    Colors.pink[500],
    Colors.purple[500],
    Colors.orange[500],
  ];
  List<Color> randcolorlight = [
    Colors.red[100],
    Colors.green[100],
    Colors.blue[100],
    Colors.yellow[100],
    Colors.pink[100],
    Colors.purple[100],
    Colors.orange[100],
  ];
  Color rColor;
  Color randomColor() {
    Random random = new Random();
    int randomNumber = random.nextInt(7);
    rColor = randcolorlight[randomNumber];
    return randcolor[randomNumber];
  }

  VerifyCourseTile({this.courseId,this.uid,this.email,this.name});  

  verify() async{
    await FirebaseFirestore.instance.collection("users").doc(uid).collection("enrolledCourses").doc(courseId).update({"isVerified" : true});
    await FirebaseFirestore.instance.collection("Courses").doc(courseId).collection("pendingRequests").doc(uid).delete();
    await FirebaseFirestore.instance.collection("Courses").doc(courseId).collection("enrolledStudents").doc(uid).set({"uid" : uid});
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Color(0xFFE095F7),
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    name,
                    style: TextStyle(
                      // color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(onPressed: (){ verify();},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 5,
                  ),
                child: Text("Verify?"),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: Color(0xFFEEEEEE),
                color: rColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Text(email)),
        ],
      ),
    );
  }
}
