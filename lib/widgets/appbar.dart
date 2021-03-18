import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String title="";
  CustomAppBar({this.title});
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text(this.title),
    );
  }
}
