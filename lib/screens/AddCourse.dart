import 'dart:async';

import 'package:classroom_management/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
  GlobalKey<FormFieldState<String>>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();



  String courseID;
  String description;
  String name;

  addCourse() async {
    bool done = true;
    CollectionReference courses = FirebaseFirestore.instance.collection('Courses');
    DocumentSnapshot documentSnapshot = await courses
        .doc(courseID)
        .get();
    if (!documentSnapshot.exists) {
      courses.doc(courseID).set({
        "name": this.name,
        "description": this.description,
        "isdisabled": false,
      });
    }
    if (done) {
      SnackBar snackBar =
      SnackBar(content: Text("Successfuly Added! "));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "ADD COURSE")
          .build(context),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFD427A4),
                    Color(0xFF20BBAA),
                  ]),
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                          // borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Please enter Course info",
                                style: TextStyle(
                                  // fontSize: 92.0,
                                  color: Color(0xFFD427A4),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 24.0),
                                    // "Name" form.
                                    TextFormField(
                                      textCapitalization:
                                      TextCapitalization.words,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.verified_user),
                                        //hintText: 'What do people call you?',
                                        labelText: 'Course Code *',
                                      ),
                                      onChanged: (String value) {
                                        this.courseID= value;
                                      },
                                      onSaved: (String value) {
                                        this.courseID = value;
                                        print('courseId=$courseID');
                                      },
                                    ),
                                    const SizedBox(height: 24.0),
                                    // "Phone number" form.
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.book_rounded),
                                        //hintText: 'Phone Number',
                                        labelText: 'Course Name',
                                      ),
                                      keyboardType: TextInputType.phone,
                                      onChanged: (String value) {
                                        this.name = value;
                                      },
                                      onSaved: (String value) {
                                        this.name = value;
                                        print('phoneNumber=$name');
                                      },
                                    ),
                                    const SizedBox(height: 24.0),
                                    // "Email" form.
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.email),
                                        //hintText: 'Your email address',
                                        labelText: 'Description *',
                                      ),
                                      onChanged: (String value) {
                                        this.description = value;
                                      },
                                      onSaved: (String value) {
                                        this.description = value;
                                      },
                                    ),

                                    SizedBox(
                                      height: 16.0,
                                    ),

                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: 60,
                                            height: 35,
                                            child: RaisedButton(
                                              onPressed: () {
                                                addCourse();
                                              },
                                              elevation: 8.0,
                                              child: Center(
                                                child: Text("Add Course"),
                                              ),
                                              color:
                                              Theme.of(context).accentColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

