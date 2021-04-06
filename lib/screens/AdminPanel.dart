import 'package:classroom_management/screens/AddCourse.dart';
import 'package:classroom_management/screens/AddProf.dart';
import 'package:classroom_management/screens/AssignCourses.dart';
import 'package:classroom_management/screens/RemoveCourse.dart';
import 'package:classroom_management/screens/RemoveProf.dart';
import 'package:classroom_management/screens/RemoveStudent.dart';
import 'package:flutter/material.dart';


class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("ADMIN PANEL")),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFAD70FA), Color(0xFF8857DF)])),
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
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Divider(),
              SizedBox(height: 6,),
              // Divider(),
              SizedBox(height: 6,),
              FlatButton(
                onPressed:(){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProf()));
                },
                hoverColor: Colors.white60,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('ENTER', style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    // backgroundColor: Colors.black,
                  )
                  ),
                ),
                textColor: Colors.white,
                shape: RoundedRectangleBorder(side: BorderSide(
                  color: Colors.white70,
                  width: 5,
                  style: BorderStyle.solid,
                ), borderRadius: BorderRadius.circular(50)),
              ),
              // GestureDetector(
              //   onTap:(){
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => AddProf()));
              //   },
              //   child: Container(
              //     decoration: BoxDecoration(
              //       color: Colors.black,
              //       shape: BoxShape.circle,
              //     ),
              //       child: Text('ADD PROFESSOR'),
              //     // child: ElevatedButton(
              //     // onPressed:(){
              //     //   Navigator.push(context,
              //     //   MaterialPageRoute(builder: (context) => AddProf()));
              //     // },
              //     // child: Text('ADD PROFESSOR')
              //     // ),
              //   ),
              // ),
              SizedBox(height: 6,),
              // Divider(),
              SizedBox(height: 6,),
              ElevatedButton(
                  onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RemoveProf()));
                  },
                  child: Text('REMOVE PROFESSOR')
              ),
              SizedBox(height: 6,),
              // Divider(),
              SizedBox(height: 6,),
              ElevatedButton(
                  onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCourse()));
                  },
                  child: Text('ADD COURSE')
              ),
              SizedBox(height: 6,),
              // Divider(),
              SizedBox(height: 6,),
              ElevatedButton(
                  onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AssignCourses()));
                  },
                  child: Text('ASSIGN COURSE')
              ),
              SizedBox(height: 6,),
              // Divider(),
              SizedBox(height: 6,),
              ElevatedButton(
                  onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RemoveCourse()));
                  },
                  child: Text('REMOVE COURSE')
              ),
              SizedBox(height: 6,),
              // Divider(),
              SizedBox(height: 6,),
              ElevatedButton(
                  onPressed:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RemoveStudent()));
                  },
                  child: Text('REMOVE STUDENT')
              ),
              SizedBox(height: 6,),
              // Divider(),
              SizedBox(height: 6,),
            ],
          ),
        ),
      ),
    );
  }
}
