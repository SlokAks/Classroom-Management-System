import 'package:classroom_management/screens/Announcements.dart';
import 'package:classroom_management/screens/assignments.dart';
import 'package:classroom_management/screens/chat_screen.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  String courseId;
  String title = "NA";
  String description = "NA";
  Course(this.courseId, {this.title, this.description});
  @override
  _CourseState createState() => _CourseState(courseId:this.courseId,title: this.title,description: this.description);
}

class _CourseState extends State<Course> {
  String courseId;
  String title = "NA";
  String description = "NA";
  _CourseState({this.courseId,this.title,this.description});
  @override
  Widget build(BuildContext context) {
    final _kTabPages = <Widget>[
      Announcements(courseId),
      Assignments(courseId: courseId,title: title,description: description,),
     ChatScreen(courseId: courseId,),
    ];
    final _kTabs = <Tab>[
      const Tab(icon: Icon(Icons.announcement), text: 'Announcements'),
      const Tab(icon: Icon(Icons.assignment), text: 'Assignments'),
      const Tab(icon: Icon(Icons.message), text: 'Class Chat'),
    ];
    return DefaultTabController(
      length: _kTabs.length,
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title:  Text(this.title),
          backgroundColor: Theme.of(context).accentColor,
          // If `TabController controller` is not provided, then a
          // DefaultTabController ancestor must be provided instead.
          // Another way is to use a self-defined controller, c.f. "Bottom tab
          // bar" example.
          bottom: TabBar(
            tabs: _kTabs,
          ),
        ),
        body: TabBarView(
          children: _kTabPages,
        ),
      ),
    );
  }
}
