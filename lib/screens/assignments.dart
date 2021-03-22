import 'package:classroom_management/widgets/CutomAssignmentTile.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:classroom_management/widgets/appbar.dart';

class Assignments extends StatefulWidget {
  @override
  _AssignmentsState createState() => _AssignmentsState();
}

class _AssignmentsState extends State<Assignments> {
  List <CustomAssignmentListTile> list=[];

  @override
  void initState() {
    // TODO: implement initState
    list.add(CustomAssignmentListTile(widget : Icon(Icons.assessment),title: "SOE : Assignment -1 (Demo)",));
    list.add(CustomAssignmentListTile(widget : Icon(Icons.assessment),title: "phantom",));
    list.add(CustomAssignmentListTile(widget : Icon(Icons.assessment),title: "phantom",));
    list.add(CustomAssignmentListTile(widget : Icon(Icons.assessment),title: "vip",));
    list.add(CustomAssignmentListTile(widget : Icon(Icons.assessment),title: "vip",));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(title: "Assignments",).build(context),
      body: ListView(
        children: list,
      ),

    );
  }
}
