import 'package:classroom_management/widgets/AnnouncementTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Announcements extends StatefulWidget {
  String courseId;
  Announcements(this.courseId);
  @override
  _AnnouncementsState createState() => _AnnouncementsState(courseId);
}

class _AnnouncementsState extends State<Announcements> {
  String courseId;
  _AnnouncementsState(this.courseId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(
        title: "Announcements",
      ).build(context),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("Courses")
            .doc(courseId)
            .collection("Announcements")
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data.docs.map(
              (document) {
                // DocumentReference user = document['user'];

                return AnnouncementTile(
                  document['text'],
                  userName: document['userId'],
                  announcementTime: document['time'],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
