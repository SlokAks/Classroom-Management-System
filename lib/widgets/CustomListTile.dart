import 'package:classroom_management/screens/CourseDescription.dart';
import 'package:classroom_management/variables/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  String courseId;
  Widget widget;
  String title;
  String description;
  bool isEnroled = false;
  bool isVerified=false;
  enrolCourse() async {
    CollectionReference usersEnroledCourses = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection("enrolledCourses");
    await usersEnroledCourses.doc(courseId).set({
      "isVerified" : false
    });
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get();
    await FirebaseFirestore.instance.collection("Courses").doc(courseId).collection("pendingRequests").doc(currentUser.uid).set({
      "uid" : currentUser.uid,
      "name" : documentSnapshot.data()['name'],
      "email" : documentSnapshot.data()['email']
    });
    isEnroled = true;
  }

  unEnrolCourse() async {
    CollectionReference usersEnroledCourses = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection("enrolledCourses");
    await usersEnroledCourses.doc(courseId).delete();
    await FirebaseFirestore.instance.collection("Courses").doc(courseId).collection("enrolledStudents").doc(currentUser.uid).delete();
    isEnroled = false;
  }

  CustomListTile(this.courseId,
      {this.widget, this.title, this.description, this.isEnroled,this.isVerified});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ListTile(
              //   leading: widget,
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFF00CCCC),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Color(0xFF00CCCC),
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFDEDEDC),
                  // color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(isEnroled
                                ? "Want to Unenrol from $title? (Warning : All course Progress & Submissions would be deleted!)"
                                : "Want to Enrol in $title"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  isEnroled ? unEnrolCourse() : enrolCourse();

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context) => AvailableCourses()));
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        ).then((returnVal) {
                          if (returnVal != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('You clicked: $returnVal'),
                                action: SnackBarAction(
                                    label: 'OK', onPressed: () {}),
                              ),
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isEnroled ? (  isVerified?"Enroled":"Request Pending"): "Not Enroled",
                          style: TextStyle(
                              color: isEnroled ? (isVerified?Colors.green:Colors.blue) : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
//color: Colors.white70,
//                    color: isEnroled?Colors.green:Colors.red,
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseDescription(
                                courseId,
                                title: title,
                                description: description,
                              )),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Course Details",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red, // background
                        onPrimary: Colors.white, // foreground
                      ),
                    ),
                  ],
                ),
              ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
