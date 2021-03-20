import 'package:classroom_management/screens/CourseDescription.dart';
import 'package:flutter/material.dart';

//ListTile CustomListTile({Widget widget,String title}){
//
//  return ListTile(
//    leading: widget,
//    title: Text(title,style: TextStyle(
//      fontSize: 22.0,
//      fontWeight: FontWeight.bold
//    ),),
//  );
//}
class CustomListTile extends StatelessWidget {
  Widget widget;
  String title;
  String description;
  CustomListTile({this.widget, this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseDescription(
                        title: title,
                        description: description,
                      )),
            );
          },
          child: ListTile(
            leading: widget,
            title: Text(
              title,
              style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Divider(),
      ],
    );
  }
}
