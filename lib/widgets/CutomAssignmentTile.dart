import 'package:classroom_management/screens/AssignmentView.dart';
import 'package:classroom_management/screens/EditAssignment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class CustomAssignmentListTile extends StatelessWidget {
  Widget widget;
  String courseId;
  String title;
  String description;
  String url;
  Timestamp dueDate;
  String assignmentId;
  bool isProf=false;
  CustomAssignmentListTile({this.courseId,this.title,this.description,this.dueDate,this.url,this.assignmentId,this.isProf});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 14.0,
        child: Container(
            child: Column(
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                     Text(title==null?"":title),
                     SizedBox(width: 20.0,),
                     Text("Due Date : " + dueDate.toDate().toString()) ,

                   ],
                 ),
               ),

               SizedBox(height: 5.0,),
               Divider(),
               SizedBox(height: 5.0,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Align(
                     alignment: Alignment.topLeft,
                     child: Text(description==null?"":description,textAlign: TextAlign.left,)),
               ),
            Divider(),
            SizedBox(height: 5.0,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                     Text("Download Assignment "),
                     SizedBox(height: 20.0,),
                     IconButton(onPressed:(){
                       html.window.open(url, 'new tab');
                     }, icon: Icon(Icons.assignment)),
                     SizedBox(width: 60.0,),
                     ElevatedButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context) => AssignmentView(title: this.title,description: this.description,courseId: this.courseId,assignmentId: this.assignmentId,dueDate: dueDate,url : this.url)));
                     }, child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("Go to Assignment"),
                     ),),
                     SizedBox(width: 60.0,),
                     if(isProf)
                     ElevatedButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => EditAssignment(courseId: courseId,AssignmentId: assignmentId,))) ;
                     }, child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("Edit Assignment"),
                     ),)
                   ],
                 ),
               )

             ],
            ),
        ),
      ),
    );
  }
}
