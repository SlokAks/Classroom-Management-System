import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnouncementTile extends StatelessWidget {
  Icon icon;
  String userName;
  Timestamp announcementTime;
  String announcementDescription;

  AnnouncementTile(this.announcementDescription,
      {this.userName, this.announcementTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 80.0,
      height: 48.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.account_circle_sharp,
                size: 25,
              ),
              Column(
                children: <Widget>[
                  Text(userName),
                  Text(announcementTime.toDate().toString()),
                ],
              ),
            ],
          ),
          Text(announcementDescription),
        ],
      ),
    );
  }
}
