import 'package:classroom_management/screens/AddCourse.dart';
import 'package:classroom_management/screens/AddProf.dart';
import 'package:classroom_management/screens/AssignCourses.dart';
import 'package:classroom_management/screens/RemoveCourse.dart';
import 'package:classroom_management/screens/RemoveProf.dart';
import 'package:classroom_management/screens/RemoveStudent.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("ADMIN PANEL"),
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
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFD427A4),
                  Color(0xFF20BBAA),
                ]),
          ),
          child: Row(
            children: [
              Expanded(flex:1,child: Container()),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Divider(),
                    Divider(),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AddCourse()));
                      },
                      hoverColor: Colors.white60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('ADD COURSE', style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              // backgroundColor: Colors.black,
                            )
                            ),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.white70,
                        width: 5,
                        style: BorderStyle.solid,
                      ), borderRadius: BorderRadius.circular(50)),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AssignCourses()));
                      },
                      hoverColor: Colors.white60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('ASSIGN COURSE', style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              // backgroundColor: Colors.black,
                            )
                            ),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.white70,
                        width: 5,
                        style: BorderStyle.solid,
                      ), borderRadius: BorderRadius.circular(50)),
                    ),
                    // FlatButton(
                    //   onPressed: () {
                    //     Navigator.push(context,
                    //         MaterialPageRoute(builder: (context) => RemoveCourse()));
                    //   },
                    //   hoverColor: Colors.white60,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Text('REMOVE COURSE', style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 26,
                    //       // backgroundColor: Colors.black,
                    //     )
                    //     ),
                    //   ),
                    //   textColor: Colors.white,
                    //   shape: RoundedRectangleBorder(side: BorderSide(
                    //     color: Colors.white70,
                    //     width: 5,
                    //     style: BorderStyle.solid,
                    //   ), borderRadius: BorderRadius.circular(50)),
                    // ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RemoveStudent()));
                      },
                      hoverColor: Colors.white60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('DISABLE STUDENT', style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              // backgroundColor: Colors.black,
                            )
                            ),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.white70,
                        width: 5,
                        style: BorderStyle.solid,
                      ), borderRadius: BorderRadius.circular(50)),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AddProf()));
                      },
                      hoverColor: Colors.white60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('ADD PROFESSOR', style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              // backgroundColor: Colors.black,
                            )
                            ),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.white70,
                        width: 5,
                        style: BorderStyle.solid,
                      ), borderRadius: BorderRadius.circular(50)),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => RemoveProf()));
                      },
                      hoverColor: Colors.white60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('DISABLE PROFESSOR', style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              // backgroundColor: Colors.black,
                            )
                            ),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.white70,
                        width: 5,
                        style: BorderStyle.solid,
                      ), borderRadius: BorderRadius.circular(50)),
                    ),
                    Divider(),
                    Divider(),
                  ],
                ),
              ),
              Expanded(flex:1,child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}