import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RemoveCourse extends StatefulWidget {
  @override
  _RemoveCourseState createState() => _RemoveCourseState();
}

class _RemoveCourseState extends State<RemoveCourse> {
  CollectionReference courseRef=FirebaseFirestore.instance.collection("Courses");
  remCourse(String id){
    setState(() async{
      CollectionReference users = FirebaseFirestore.instance.collection('Courses');
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
        title: Text('REMOVE COURSE'),
      ),
      body:Container(
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
                                child: Text('REMOVE'),
                                onPressed: () {
                                  remCourse(document.id);
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
