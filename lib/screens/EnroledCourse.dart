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
              return CustomListTile(
                widget: Icon(Icons.book),
                title: "asd",
                description: "sad",
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
