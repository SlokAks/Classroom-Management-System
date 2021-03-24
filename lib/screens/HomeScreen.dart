import 'package:classroom_management/screens/CourseDescription.dart';
import 'package:classroom_management/screens/course.dart';
import 'package:classroom_management/widgets/EnrolledCoursesTile.dart';
import 'package:classroom_management/widgets/HomeAnnouncementTile.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AnnouncementsContainer {
  String course;
  String text;
  Timestamp time;
  String userId;
  AnnouncementsContainer(this.course, this.text, this.userId, this.time);
}

MaterialApp HomeScreen(String name) {
  CalendarController _calendarController = CalendarController();

  return MaterialApp(
    home: Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Welcome " + name),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Image(
                      width: 200,
                      height: 100,
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  Expanded(
                      flex: 4, child: Center(child: Text("Welcome " + name))),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      //TODO onpressed
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      icon: const Icon(Icons.account_circle_sharp),
                      //TODO onpressed
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: StreamBuilder(
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
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('enrolledCourses')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: circularProgress(),
                          );
                        }

                        List<dynamic> list = snapshot.data.docs
                            .map((enrolledCoursesSnapshot) => FutureBuilder(
                                  future: FirebaseFirestore.instance
                                      .collection("Courses")
                                      .doc(enrolledCoursesSnapshot.id)
                                      .get(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          courseSnapsot) {
                                    if (courseSnapsot.hasError) {
                                      return Text("Something went wrong");
                                    }

                                    if (courseSnapsot.connectionState ==
                                        ConnectionState.done) {
                                      return GestureDetector(
                                        onTap: (){

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Course(
                                                    courseSnapsot.data
                                                        .id,
                                                  title: courseSnapsot.data
                                                      .data()['name'],
                                                  description:   courseSnapsot.data
                                                      .data()['description'],
                                                )),
                                          );
                                        },
                                        child: EnrolledCoursesTile(
                                            courseSnapsot.data.data()['name'],
                                            "NA",
                                            courseSnapsot.data
                                                .data()['description']),
                                      );
                                    }
                                    return Center(
                                      child: circularProgress(),
                                    );
                                  },
                                ))
                            .toList();

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return list[index];
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        TableCalendar(calendarController: _calendarController),
                      ],
                    )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
