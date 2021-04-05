import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnrolledCoursesTile extends StatelessWidget {
  String courseName, courseId;

  EnrolledCoursesTile(this.courseName, this.courseId);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 20,
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      child: Image.asset(
                        'images/courseTile.png',
                        fit: BoxFit.fill,
                      ),
                    )),
                Expanded(
                  flex: 1,
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              courseName + " (" + courseId + ")",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Expanded(flex: 3, child: Container()),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    AspectRatio(
                      aspectRatio: 3/4,
                      child: CircleAvatar(
                        // radius: 30,
                        child: Icon(
                          Icons.person,
                          // size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container())
            ],
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
