import 'package:classroom_management/widgets/EnrolledCoursesTile.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

MaterialApp HomeScreen(String name) {
  return MaterialApp(
    theme: ThemeData.dark(),
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
                        child: Text("Announcements"),
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
                                      return EnrolledCoursesTile(
                                          courseSnapsot.data.data()['name'],
                                          "NA",
                                          courseSnapsot.data
                                              .data()['description']);
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
                      child: Center(
                        child: Text("Calender"),
                      ),
                    ),
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
