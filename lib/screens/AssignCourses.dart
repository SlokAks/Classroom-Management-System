import 'package:classroom_management/screens/ChooseCourse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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
                          child: Row(
                            children: [
                              Expanded(child: Container()),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  margin: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(document["name"],
                                      style: TextStyle(color: Colors.white),
                                      ),
                                      // Text(document["email"]),
                                      // Text(document["contact"]),
                                      RaisedButton(
                                        color: Colors.blue,
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
                                ),
                              ),
                              Expanded(child: Container()),
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
