import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAnnouncementTile extends StatelessWidget {
  String courseId;
  Timestamp announcementTime;
  String announcementDescription;

  HomeAnnouncementTile(this.announcementDescription,
      {this.courseId, this.announcementTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(courseId),
              Text(announcementTime.toDate().toString()),
            ],
          ),
          Text(announcementDescription),
        ],
      ),
    );
  }
}
