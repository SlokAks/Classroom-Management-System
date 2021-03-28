import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String title="";
  CustomAppBar({this.title});
  @override
  AppBar build(BuildContext context) {
    return   AppBar(
      // backgroundColor: Colors.red,
      // leading: const Icon(Icons.tag_faces),
      title: Center(child: Text(this.title)),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFAD70FA),
                  Color(0xFF8857DF)
                ])
        ),
      ),
    );
  }
}
