import 'package:classroom_management/widgets/CustomListTile.dart';
import 'package:classroom_management/widgets/EnroledCourseListTile.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnroledCourses extends StatefulWidget {
  @override
  _EnroledCoursesState createState() => _EnroledCoursesState();
}

class _EnroledCoursesState extends State<EnroledCourses> {
  User user = FirebaseAuth.instance.currentUser;
  CollectionReference dbCourses =
      FirebaseFirestore.instance.collection('courses');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
      backgroundColor: Colors.white,
      // leading: const Icon(Icons.tag_faces),
      title: Center(child: Text("Enrolled Courses")),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFAD70FA),
                  Color(0xFF8857DF)
                ])
        ),
      ),
      actions: <Widget>[

        IconButton(
          icon: const Icon(Icons.account_circle_sharp),
          //TODO onpressed
        ),
        // PopupMenuButton(
        //   itemBuilder: (BuildContext context) {
        //     return [
        //       const PopupMenuItem(child: Text('Boat')),
        //       const PopupMenuItem(child: Text('Train'))
        //     ];
        //   },
        // )
      ],
    ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('enrolledCourses')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child:circularProgress(),
            );
          }
          return ListView(
            children: snapshot.data.docs.map(
              (enrolledCoursesSnapshot) {
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

                    if (courseSnapsot.connectionState == ConnectionState.done) {
                      return EnroledCourseListTile(
                        enrolledCoursesSnapshot.id,
                        title: courseSnapsot.data.data()["name"] +
                            "(" +
                            enrolledCoursesSnapshot.id +
                            ")",
                        description: courseSnapsot.data.data()["description"],
                      );
                    }
                    return Center(
                      child: circularProgress(),
                    );
                  },
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
