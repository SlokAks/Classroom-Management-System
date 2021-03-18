import 'package:classroom_management/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/CustomListTile.dart';
class EnroledCourses extends StatefulWidget {
  @override
  _EnroledCoursesState createState() => _EnroledCoursesState();
}

class _EnroledCoursesState extends State<EnroledCourses> {
  @override
  Widget build(BuildContext context) {
    List <CustomListTile> list=[];

    @override
    void initState() {
      // TODO: implement initState
      list.add(CustomListTile(widget: Icon(Icons.book),title: "Software Engineering",));
      list.add(CustomListTile(widget: Icon(Icons.book),title: "Software Engineering",));
      list.add(CustomListTile(widget: Icon(Icons.book),title: "Software Engineering",));
      list.add(CustomListTile(widget: Icon(Icons.book),title: "Software Engineering",));
      super.initState();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        drawer: NavDrawer(),
        appBar: CustomAppBar(title: "Enroled Courses",).build(context),
        body: ListView(
          children: list,
        ),

      );
    }
  }
}
