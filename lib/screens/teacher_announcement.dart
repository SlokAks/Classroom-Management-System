import 'package:classroom_management/widgets/HomeAnnouncementTile.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class MakeAnnouncement extends StatefulWidget {
  @override
  _MakeAnnouncementState createState() => _MakeAnnouncementState();
}

class _MakeAnnouncementState extends State<MakeAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Make Announcement'),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection("enrolledCourses")
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> coursesSnapshot) {
              if (!coursesSnapshot.hasData) {
                return circularProgress();
              }

              return ListView(
                children:
                coursesSnapshot.data.docs.map((courses) {
                  print(courses.id);
                  return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Courses")
                        .doc(courses.id)
                        .collection("Announcements")
                        .orderBy('time', descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot>
                        announcementSnapshot) {
                      if (!announcementSnapshot.hasData) {
                        return Text("Looading");
                      }
                      return Column(
                          children: announcementSnapshot.data.docs
                              .map((announcement) {
                            return HomeAnnouncementTile(
                              announcement.data()['text'],
                              announcementTime:
                              announcement.data()['time'],
                              courseId: courses.id,
                            );
                          }).toList());

                      // return Text("Loading");
                    },
                  );
                }).toList(),
              );
            },
          ),
          Container(
            child: Text('Add Assignemnt'),
          ),
        ],
      )
    );
  }
}
