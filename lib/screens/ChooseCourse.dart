import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// String pid;
class ChooseCourse extends StatefulWidget {

  String profID;
  ChooseCourse(this.profID);
  @override
  _ChooseCourseState createState() => _ChooseCourseState();
}
class _ChooseCourseState extends State<ChooseCourse> {
  CollectionReference courseRef=FirebaseFirestore.instance.collection("Courses");
  @override

  addcourse(String PID,String CID)async{
    CollectionReference user=FirebaseFirestore.instance.collection("users");
    await user
        .doc(PID).collection("CoursesTeaching").doc(CID)
        .set({});
  }


  Widget build(BuildContext context) {
    String pid=widget.profID;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.white,
        child: StreamBuilder(
            stream: courseRef.snapshots(),
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

                    if(!document["isdisabled"])
                    {
                      return
                        Container(
                          child: Column(
                            children: [
                              Text(document["name"]),
                              Text(document["description"]),
                              Text(document.id),
                              RaisedButton(
                                child: Text('ADD'),
                                onPressed: () {
                                  addcourse(pid,document.id);
                                },
                              ),
                            ],
                          ),
                        );
                    }
                    else{
                      return Container();
                    }
                  },
                ).toList(),
              );
            }),
      ),
    );
  }
}
