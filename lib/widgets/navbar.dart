import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:classroom_management/screens/home.dart';
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpeg'))),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Available Courses',style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold
            ),),
            onTap: () => {

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.book_online),
            title: Text('Enroled Courses',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold
              ),),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Edit Profile',style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold
            ),),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback',style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold
            ),),
            onTap: () => {Navigator.of(context).pop()},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout',style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold
            ),),
            onTap: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
