import 'dart:html';

import 'package:classroom_management/variables/variables.dart';
import 'package:classroom_management/widgets/CustomListTile.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AvailableCourses extends StatefulWidget {
  @override
  _AvailableCoursesState createState() => _AvailableCoursesState();
}

class _AvailableCoursesState extends State<AvailableCourses> {
  List<CustomListTile> list = [];
  Map<String, bool> enroled = {};
  bool isLoading = true;
  bool isVerified = false;
  getEnroledCourses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection("enrolledCourses")
        .get();
    List<DocumentSnapshot> enrol = querySnapshot.docs.toList();
    for (int i = 0; i < enrol.length; i++) {
//      enroled.add(enrol[i].id.toString());
      enroled[enrol[i].id.toString()] = enrol[i].data()['isVerified'];
    }
    setState(() {
      isLoading = false;
    });
  }

  CollectionReference courseCollectionReference =
      FirebaseFirestore.instance.collection("Courses");
  @override
  void initState() {
    // TODO: implement initState
    getEnroledCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? Center(
              child: circularProgress(),
            )
          : StreamBuilder(
              stream: courseCollectionReference.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView(
                  children: snapshot.data.docs.map(
                    (document) {
                      bool isVerified = false;
                      bool isEnroled = enroled.containsKey(document.id);
                      print(isVerified);
                      print(isEnroled);
                      if (isEnroled) {
                        isVerified = enroled[document.id];
                      }

                      return CustomListTile(
                        document.id,
                        title: document["name"] + "(" + document.id + ")",
                        description: document["description"],
                        isEnroled: isEnroled,
                        isVerified: isVerified,
                      );
                    },
                  ).toList(),
                );
              }),
    );
  }
}
