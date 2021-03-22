import 'dart:html';

import 'package:classroom_management/models/course.dart';
import 'package:classroom_management/widgets/CustomListTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:classroom_management/variables/variables.dart';
class AvailableCourses extends StatefulWidget {
  @override
  _AvailableCoursesState createState() => _AvailableCoursesState();
}

class _AvailableCoursesState extends State<AvailableCourses> {
  List<CustomListTile> list = [];
  List<String> enroled=[];
  bool isLoading=true;
  getEnroledCourses() async{
    QuerySnapshot querySnapshot=await FirebaseFirestore.instance
        .collection('users').doc(currentUser.uid).collection("enrolledCourses")
        .get();
    List<DocumentSnapshot> enrol = querySnapshot.docs.toList();
    for(int i=0;i<enrol.length;i++){
      enroled.add(enrol[i].id.toString());
    }
   setState(() {
     isLoading=false;
   });

  }
  CollectionReference courseCollectionReference =
      FirebaseFirestore.instance.collection("Courses");

  @override
  void initState() {
    // TODO: implement initState
    getEnroledCourses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(
        title: "Available Courses",
      ).build(context),
      body: isLoading?  Center(child: circularProgress(),)
      :StreamBuilder(
          stream: courseCollectionReference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            return ListView(
              children: snapshot.data.docs.map(
                (document) {
                  return CustomListTile(
                    document.id,
                    title: document["name"] + "(" + document.id + ")",
                    description: document["description"],
                    isEnroled: enroled.contains(document.id),
                  );
                },
              ).toList(),
            );
          }),
    );
  }
}

