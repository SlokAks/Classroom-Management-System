import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MakeAnnouncements extends StatefulWidget {
  String courseId;
  MakeAnnouncements(this.courseId);

  @override
  _MakeAnnouncementsState createState() => _MakeAnnouncementsState(courseId);
}

class _MakeAnnouncementsState extends State<MakeAnnouncements> {
  String courseId;
  CollectionReference announcementsReference;
  _MakeAnnouncementsState(String courseId) {
    this.courseId = courseId;
    announcementsReference = FirebaseFirestore.instance
        .collection("Courses")
        .doc(courseId)
        .collection("Announcements");
  }

  final _controller = TextEditingController();

  Future<void> addAnnouncement(
      String userId, Timestamp time, String text) async {
    return announcementsReference
        .add({'userId': userId, 'time': time, 'text': text})
        .then((value) => print("Annoucement Made"))
        .catchError((error) => print("Failed to make Announcement: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            TextField(
              controller: this._controller,
              maxLines: 7,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Enter Announcement Description',
                hintText: 'type something',
                border: const OutlineInputBorder(),
              ),
              onChanged: (text) => setState(() {}),
            ),
            ElevatedButton(
                onPressed: () {
                  String userId = FirebaseAuth.instance.currentUser.uid;
                  Timestamp timeStamp = Timestamp.fromDate(DateTime.now());
                  String text = _controller.text;

                  addAnnouncement(userId, timeStamp, text);
                },
                child: Text('Announce')),
          ],
        ),
      ),
    );
  }
}