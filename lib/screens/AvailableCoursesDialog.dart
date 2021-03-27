import 'package:classroom_management/screens/AvailableCourses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AvailableCoursesDialog extends StatefulWidget {
  @override
  _AvailableCoursesDialogState createState() => _AvailableCoursesDialogState();
}

class _AvailableCoursesDialogState extends State<AvailableCoursesDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(flex:2,child: Container()),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: AvailableCourses(),
            ),
          )
        ],
      ),
    );
  }
}
