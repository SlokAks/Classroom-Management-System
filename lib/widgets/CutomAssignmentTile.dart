import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class CustomAssignmentListTile extends StatelessWidget {
  Widget widget;
  String title;
  String description;
  String url;
  Timestamp dueDate;
  CustomAssignmentListTile({this.title,this.description,this.dueDate,this.url});
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
                 child: Text(description==null?"":description),
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
                     }, icon: Icon(Icons.assignment))
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
