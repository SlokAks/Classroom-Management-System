import 'package:classroom_management/widgets/CustomListTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvailableCourses extends StatefulWidget {
  @override
  _AvailableCoursesState createState() => _AvailableCoursesState();
}

class _AvailableCoursesState extends State<AvailableCourses> {
  List<CustomListTile> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(
        title: "Available Courses",
      ).build(context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('courses').snapshots(),
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
                title: document['course_name'],
                description: document['course_description'],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
