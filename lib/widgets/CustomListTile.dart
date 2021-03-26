import 'package:classroom_management/screens/CourseDescription.dart';
import 'package:classroom_management/variables/variables.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//ListTile CustomListTile({Widget widget,String title}){
//
//  return ListTile(
//    leading: widget,
//    title: Text(title,style: TextStyle(
//      fontSize: 22.0,
//      fontWeight: FontWeight.bold
//    ),),
//  );
//}
class CustomListTile extends StatelessWidget {
  String courseId;
  Widget widget;
  String title;
  String description;
  bool isEnroled = false;
  enrolCourse() async {
    CollectionReference usersEnroledCourses = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection("enrolledCourses");
    await usersEnroledCourses.doc(courseId).set({});
    isEnroled = true;
  }

  unEnrolCourse() async {
    CollectionReference usersEnroledCourses = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .collection("enrolledCourses");
    await usersEnroledCourses.doc(courseId).delete();
    isEnroled = false;
  }

  CustomListTile(this.courseId,
      {this.widget, this.title, this.description, this.isEnroled});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 14.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          ListTile(
            leading: widget,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
            ),
            trailing: Row(
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
                            onPressed: () => Navigator.pop(context, 'Cancel'),
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
                            action:
                                SnackBarAction(label: 'OK', onPressed: () {}),
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
                      isEnroled ? "Enroled" : "Not Enroled",
                      style: TextStyle(
                          color: isEnroled ? Colors.green : Colors.red,
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
        ],
      ),
    );
  }
}
