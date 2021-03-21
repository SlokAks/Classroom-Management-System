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

  CollectionReference courseCollectionReference =
      FirebaseFirestore.instance.collection("Courses");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(
        title: "Available Courses",
      ).build(context),
      body: StreamBuilder(
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
                  );
                },
              ).toList(),
            );
          }),
    );
  }
}
