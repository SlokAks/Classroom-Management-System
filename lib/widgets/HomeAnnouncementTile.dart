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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration : BoxDecoration(
              color: Color(0xFFE095F7),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(

                  child: Text(
                      courseId,
                    style: TextStyle(
                      // color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(announcementTime.toDate().toString()),
              ],
            ),
          ),

          Container(
              padding: EdgeInsets.all(8),
              decoration : BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
              ),
              child: Text(announcementDescription)),
        ],
      ),
    );
  }
}
