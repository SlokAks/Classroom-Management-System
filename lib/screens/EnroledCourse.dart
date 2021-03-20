import 'package:classroom_management/widgets/CustomListTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnroledCourses extends StatefulWidget {
  @override
  _EnroledCoursesState createState() => _EnroledCoursesState();
}

class _EnroledCoursesState extends State<EnroledCourses> {
  User user = FirebaseAuth.instance.currentUser;
  CollectionReference dbCourses =
      FirebaseFirestore.instance.collection('courses');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(
        title: "Enroled Courses",
      ).build(context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('enrolled_courses')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              String courseTitle = "NA";
              dbCourses
                  .where("course_id", isEqualTo: document['course_id'])
                  .get()
                  .then((value) => value.docs
                      .map((e) => {courseTitle = e.data()['course_name']}));
              return CustomListTile(
                widget: Icon(Icons.book),
                title: courseTitle,
                description: "NA",
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
