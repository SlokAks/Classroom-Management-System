import 'dart:math';

import 'package:classroom_management/screens/AdminPanel.dart';
import 'package:classroom_management/screens/AvailableCoursesDialog.dart';
import 'package:classroom_management/screens/CalendarWithAssignment.dart';
import 'package:classroom_management/screens/ViewProfileDialog.dart';
import 'package:classroom_management/screens/course.dart';
import 'package:classroom_management/screens/disabledAccountsWaitingPage.dart';
import 'package:classroom_management/widgets/EnrolledCoursesTile.dart';
import 'package:classroom_management/widgets/HomeAnnouncementTile.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnnouncementsContainer {
  String course;
  String text;
  Timestamp time;
  String userId;
  AnnouncementsContainer(this.course, this.text, this.userId, this.time);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "NA";
  String urll;
  bool isAdmin = false, isProf = false, isdisabled=false;
  Widget profilePicture;
  bool isLoading = true;
  void initState() {
    // TODO: implement initState
    profilePicture = CircleAvatar(child: Icon(Icons.person));
    getData();

    super.initState();
  }

  void getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((user) {
      this.setState(() {
        isAdmin = user['isAdmin'];
        isProf = user['isProf'];
        name = user['name'];
        isdisabled=user['isdisabled'];
        isLoading = false;
      });
      if (user.data().containsKey('url')) {
        if (user['url'] != null) {
          urll = user['url'];
          this.setState(() {
            profilePicture = CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(urll),
            );
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
//    theme: ThemeData.dark(),
        home: (() {
          if (isLoading)
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          else {
            if (isAdmin)
              return AdminPanel();
            else if(isdisabled)
              return DisabledUserAccount();
            else if (isProf)
              return Scaffold(
                backgroundColor: Color(0xFFF7F7F7),
                drawer: NavDrawer(),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  // leading: const Icon(Icons.tag_faces),
                  title: Center(child: Text("Welcome " + name)),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color(0xFFAD70FA),
                          Color(0xFF8857DF)
                        ])),
                  ),
                  actions: <Widget>[
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(context,
                          // MaterialPageRoute(builder: (context) => Make()));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ViewProflieDialog();
                              });
                        },
                        child: profilePicture,
                      ),
                    ),
                  ],
                ),
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return _buildWideContainers();
                  },
                ),
              );
            else
              return Scaffold(
                backgroundColor: Color(0xFFF7F7F7),
                drawer: NavDrawer(),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  // leading: const Icon(Icons.tag_faces),
                  title: Center(child: Text("Welcome " + name)),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                          Color(0xFFAD70FA),
                          Color(0xFF8857DF)
                        ])),
                  ),
                  actions: <Widget>[
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => AvailableCourses()));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AvailableCoursesDialog();
                              });
                        },
                        child: Row(
                          children: [
                            Icon(Icons.book),
                            Text('Available Course'),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(context,
                          // MaterialPageRoute(builder: (context) => Make()));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ViewProflieDialog();
                              });
                        },
                        child: profilePicture,
                      ),
                    ),
                  ],
                ),
                body: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 1420 &&
                        constraints.maxHeight > 620) {
                      return _buildNormalContainer();
                    } else {
                      return _buildWideContainers();
                    }
                  },
                ),
              );
          }
        }()));
  }

  Widget _buildNormalContainer() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 15, bottom: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color(0xFF858D8F),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF858D8F),
                                ),
                                child: Text(
                                  'Latest Announcements',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .collection("enrolledCourses")
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot>
                                      coursesSnapshot) {
                                if (!coursesSnapshot.hasData) {
                                  return circularProgress();
                                }
                                List<dynamic> list =
                                    coursesSnapshot.data.docs.map((courses) {
                                  print(courses.id);
                                  if (courses.data()['isVerified'] == false)
                                    return Container();
                                  else
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

                                        List<HomeAnnouncementTile> list =
                                            announcementSnapshot.data.docs
                                                .map((announcement) {
                                          return HomeAnnouncementTile(
                                            announcement.data()['text'],
                                            announcementTime:
                                                announcement.data()['time'],
                                            courseId: courses.id,
                                          );
                                        }).toList();

                                        List<Widget> finalList =
                                            announcementSnapshot.data.docs
                                                .map((announcement) {
                                          return HomeAnnouncementTile(
                                            announcement.data()['text'],
                                            announcementTime:
                                                announcement.data()['time'],
                                            courseId: courses.id,
                                          );
                                        }).toList();

                                        return Column(
                                            children: finalList.sublist(
                                                0, min(finalList.length, 1)));

                                        // return Text("Loading");
                                      },
                                    );
                                }).toList();
                                return ListView(
                                  children: list,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
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

                      List<dynamic> list =
                          snapshot.data.docs.map((enrolledCoursesSnapshot) {
                        if (enrolledCoursesSnapshot.data()['isVerified'] ==
                            false) return Container();
                        return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("Courses")
                              .doc(enrolledCoursesSnapshot.id)
                              .get(),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> courseSnapsot) {
                            if (courseSnapsot.hasError) {
                              return Text("Something went wrong");
                            }

                            if (courseSnapsot.connectionState ==
                                ConnectionState.done) {
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Course(
                                                courseSnapsot.data.id,
                                                title: courseSnapsot.data
                                                    .data()['name'],
                                                description: courseSnapsot.data
                                                    .data()['description'],
                                              )),
                                    );
                                  },
                                  child: EnrolledCoursesTile(
                                      courseSnapsot.data.data()['name'],
                                      enrolledCoursesSnapshot.id),
                                ),
                              );
                            }
                            return Center(
                              child: circularProgress(),
                            );
                          },
                        );
                      }).toList();

                      List<Widget> dummyList = [];

                      for (int i = 0; i < list.length; i++) {
                        if (list[i] != Container()) dummyList.add(list[i]);
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        itemCount: dummyList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return dummyList[index];
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                        // padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: CalendarWithAssignment()))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWideContainers() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: StreamBuilder(
                    stream: (() {
                      if (isProf)
                        return FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('CoursesTeaching')
                            .snapshots();
                      else
                        return FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('enrolledCourses')
                            .snapshots();
                    }()),
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
                                    return MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Course(
                                                      courseSnapsot.data.id,
                                                      title: courseSnapsot.data
                                                          .data()['name'],
                                                      description: courseSnapsot
                                                              .data
                                                              .data()[
                                                          'description'],
                                                    )),
                                          );
                                        },
                                        child: EnrolledCoursesTile(
                                            courseSnapsot.data.data()['name'],
                                            enrolledCoursesSnapshot.id),
                                      ),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
