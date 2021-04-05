import 'package:classroom_management/widgets/EnroledStudentsTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:classroom_management/models/user.dart';
class EnroledStudents extends StatefulWidget {
  String courseId;
  EnroledStudents({this.courseId});
  @override
  _EnroledStudentsState createState() => _EnroledStudentsState();
}

class _EnroledStudentsState extends State<EnroledStudents> {
  List<CurrentUser> enroledStudents = [];
  List<EnroledStudentTile> list = [];
  bool isLoading = true;

  getEnroledStudents() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
        "Courses").doc(widget.courseId).collection("enrolledStudents").get();
    List<QueryDocumentSnapshot> lis = querySnapshot.docs;
    for (int i = 0; i < lis.length; i++) {
      DocumentSnapshot stud = await FirebaseFirestore.instance.collection(
          "users").doc(lis[i].data()['uid']).get();
      CurrentUser curuser = CurrentUser.fromDocument(stud);
      enroledStudents.add(curuser);
      list.add(EnroledStudentTile(curUser: curuser,));
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getEnroledStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Enroled Students for ${widget.courseId} Course",).build(
            context),

        body: isLoading
            ? Center(child: CircularProgressIndicator(),)
            : ListView(
          children: list,
        )
    );
  }
}

