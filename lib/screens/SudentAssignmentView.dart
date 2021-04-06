import 'package:classroom_management/models/AssignmentModel.dart';
import 'package:classroom_management/models/SubmittedAssignment.dart';
import 'package:flutter/material.dart';

class StudentAssignmentView extends StatefulWidget {
  String uid="";
  String courseId="";
  StudentAssignmentView({this.uid,this.courseId});
  @override
  _StudentAssignmentViewState createState() => _StudentAssignmentViewState();
}

class _StudentAssignmentViewState extends State<StudentAssignmentView> {
  List<Assignment> assignments=[];
  List<String> submittedAssignmentsId=[];
  List<SubmittedAssignment> submittedAssignment =[];

  getData()  async{

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
