import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnrolledCoursesTile extends StatelessWidget {
  String courseName, courseInstructor, courseDescription;

  EnrolledCoursesTile(
      this.courseName, this.courseInstructor, this.courseDescription);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.elliptical(40.0, 80.0),
        ),
      ),
      child:
        Stack(
          children: [
          Container(

            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Text(courseName),
                    Text(courseInstructor),
                    Text(courseDescription),
                  ]),
                ),
                Expanded(
                  flex: 2,
                    child: Container(color: Colors.white,)
                )

              ],
            ),
          ),
            Container(
              child: Column(
                children: [
                  Expanded(
                    flex:7,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                            child: Container()),
                        Expanded(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 40,
                            child: Icon(
                                Icons.person,
                              size: 60,
                            ),
                          ),
                        ),

                        ]
                    ),
                  ),
                  Expanded(
                    flex: 4,
                      child: Container()),
                ],
              ),
            )
          ],
        ),
    //   Column(children: <Widget>[
    //     Text(courseName),
    //     Text(courseInstructor),
    //     Text(courseDescription),
    //   ]),
    );
  }
}
