import 'package:classroom_management/widgets/CutomAssignmentTile.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:classroom_management/widgets/appbar.dart';

class Assignments extends StatefulWidget {
  String courseId="NA";
  String title = "NA";
  String description = "NA";
  bool isProf;
  Assignments({this.courseId,this.title,this.description,this.isProf});
  @override
  _AssignmentsState createState() => _AssignmentsState(courseId: courseId,title: title,description: description,isProf: this.isProf);
}

class _AssignmentsState extends State<Assignments> {

   String courseId = "NA";
  String title = "NA";
  String description = "NA";
  bool isProf=false;
  _AssignmentsState({this.courseId,this.title,this.description,this.isProf});
  List <CustomAssignmentListTile> list=[];
  CollectionReference assignments;

@override
  void initState() {
    // TODO: implement initState
  assignments=FirebaseFirestore.instance.collection('Courses').doc(courseId).collection("Assignments");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: assignments.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: circularProgress(),
          );
        }
        if(snapshot.hasData){
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return CustomAssignmentListTile(
              courseId: this.courseId,
              assignmentId: document.id,
              title: document.data()['title'],
              description: document.data()['Description'],
              url: document.data()['link'],
              dueDate: document.data()['dueDate'],
              isProf: isProf,
            );
          }).toList(),
        );}
        else{
          return Center(
            child: circularProgress(),
          );
        }
      },
    );
  }
}
