import 'dart:html';

import 'package:classroom_management/widgets/CourseAnnouncementTile.dart';
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
    return Expanded(
      flex: 2,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Courses")
            .doc(courseId)
            .collection("Announcements")
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView(
            children: snapshot.data.docs.map((document) {
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(document['userId'].trim())
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return AnnouncementTile(
                      document['text'],
                      userName: snapshot.data.data()['name'],
                      announcementTime: document['time'],
                    );
                  }
                  return Text("loading");
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
