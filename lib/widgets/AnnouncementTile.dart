import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnnouncementTile extends StatelessWidget {
  Icon icon;
  String userName;
  Timestamp announcementTime;
  String announcementDescription;

  List<Color> randcolor = [
    Colors.red[500],
    Colors.green[500],
    Colors.blue[500],
    Colors.yellow[500],
    Colors.pink[500],
    Colors.purple[500],
    Colors.orange[500],
  ];
  List<Color> randcolorlight = [
    Colors.red[100],
    Colors.green[100],
    Colors.blue[100],
    Colors.yellow[100],
    Colors.pink[100],
    Colors.purple[100],
    Colors.orange[100],
  ];
  Color rColor;
  Color randomColor() {
    Random random = new Random();
    int randomNumber = random.nextInt(7);
    rColor = randcolorlight[randomNumber];
    return randcolor[randomNumber];
  }

  AnnouncementTile(this.announcementDescription,
      {this.userName, this.announcementTime});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: const EdgeInsets.all(10.0),
    //   child: Column(
    //     children: <Widget>[
    //       Row(
    //         children: <Widget>[
    //           Icon(
    //             Icons.account_circle_sharp,
    //             size: 25,
    //           ),
    //           Column(
    //             children: <Widget>[
    //               Text(userName),
    //               Text(announcementTime.toDate().toString()),
    //             ],
    //           ),
    //         ],
    //       ),
    //       Text(announcementDescription),
    //     ],
    //   ),
    // );

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Color(0xFFE095F7),
              color: randomColor(),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    userName,
                    style: TextStyle(
                        // color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(announcementTime.toDate().toString()),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: Color(0xFFEEEEEE),
                color: rColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Text(announcementDescription)),
        ],
      ),
    );
  }
}
