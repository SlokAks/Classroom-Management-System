import 'package:classroom_management/screens/CourseDescription.dart';
import 'package:flutter/material.dart';

class CustomAssignmentListTile extends StatelessWidget {
  Widget widget;String title;
  CustomAssignmentListTile({this.widget,this.title});
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CourseDescription()),
            );
          },
          child: ListTile(
            leading: widget,
            title: Text(title,style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold
            ),),
          ),
        ),
        Divider(),
      ],
    );
  }
}