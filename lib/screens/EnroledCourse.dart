import 'package:classroom_management/widgets/EnrolledCoursesTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:classroom_management/widgets/progress.dart';
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
            .collection('enrolledCourses')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: circularProgress(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map(
              (enrolledCoursesSnapshot) {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("Courses")
                      .doc(enrolledCoursesSnapshot.id)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> courseSnapsot) {
                    if (courseSnapsot.hasError) {
                      return Text("Something went wrong");
                    }

                    if (courseSnapsot.connectionState == ConnectionState.done) {
                      return EnrolledCoursesTile(
                          courseSnapsot.data.data()['name'],
                          "NA",
                          courseSnapsot.data.data()['description']);
                    }
                    return Center(
                      child: circularProgress(),
                    );
                  },
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
