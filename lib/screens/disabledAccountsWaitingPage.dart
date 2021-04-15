import 'package:classroom_management/screens/home.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DisabledUserAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFFAD70FA),
                    Color(0xFF8857DF)
                  ])),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Row(
              children: [
                Icon(Icons.logout),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFFAD70FA),
                  Color(0xFF8857DF)
                ])),
        child: Center(
          child: Text(
            'YOUR ACCOUNT HAS BEEN DISABLED',
                style: TextStyle(
              color: Colors.white
          ),
          ),
        ),
      ),
    );
  }
}
