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
        title: Text("ADMIN"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 6,
            ),
            Divider(),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddProf()));
                },
                child: Text('ADD PROFESSOR')),
            SizedBox(
              height: 6,
            ),
            Divider(),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RemoveProf()));
                },
                child: Text('REMOVE PROFESSOR')),
            SizedBox(
              height: 6,
            ),
            Divider(),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddCourse()));
                },
                child: Text('ADD COURSE')),
            SizedBox(
              height: 6,
            ),
            Divider(),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AssignCourses()));
                },
                child: Text('ASSIGN COURSE')),
            SizedBox(
              height: 6,
            ),
            Divider(),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RemoveCourse()));
                },
                child: Text('REMOVE COURSE')),
            SizedBox(
              height: 6,
            ),
            Divider(),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RemoveStudent()));
                },
                child: Text('REMOVE STUDENT')),
            SizedBox(
              height: 6,
            ),
            Divider(),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
