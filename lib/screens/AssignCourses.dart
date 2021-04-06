import 'package:classroom_management/screens/ChooseCourse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignCourses extends StatefulWidget {
  @override
  _AssignCoursesState createState() => _AssignCoursesState();
}

class _AssignCoursesState extends State<AssignCourses> {
  CollectionReference userRef=FirebaseFirestore.instance.collection("users");
  remProf(String id){
    setState(() async{
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(id).update({
        "isdisabled":true,
      });
    });
  }
  @override
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Course'),
      ),
      body:Container(
        child: StreamBuilder(
            stream: userRef.snapshots(),
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

                    if(!document["isdisabled"]&&document["isProf"]) {
                      return
                        Container(
                          child: Column(
                            children: [
                              Text(document["name"]),
                              // Text(document["email"]),
                              // Text(document["contact"]),
                              RaisedButton(
                                child: Text('ASSIGN COURSE'),
                                onPressed: () {
                                  // remProf(document["id"]);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ChooseCourse(document.id);
                                      });
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
