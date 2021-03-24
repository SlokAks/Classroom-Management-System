import 'dart:html';

import 'package:classroom_management/widgets/AnnouncementTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MakeAnnouncements.dart';

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
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MakeAnnouncements(courseId)),
              );
            },
            child: Container(
              height: 130.0,
              width: 450.0,
              child: Card(
                elevation: 14.0,
                child: Container(
                  height: 130.0,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: Center(
                    child: Text(
                      "Make Announcement",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("Courses")
                  .doc(courseId)
                  .collection("Announcements")
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          .doc(document['userId'])
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
          ),
        ],
      ),
    );
  }
}
