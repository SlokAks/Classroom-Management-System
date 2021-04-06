import 'dart:html';

import 'package:classroom_management/widgets/appbar.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordian/gf_accordian.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/getwidget.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: CustomAppBar(title: "About Classroom Management System",).build(context),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GFAccordion(
//                collapsedTitlebackgroundColor: Colors.transparent,
//                expandedTitlebackgroundColor: Colors.transparent,
//                contentbackgroundColor: Colors.transparent,
                collapsedIcon: Text(''),
                expandedIcon: Text(''),
                showAccordion: true,
                titlePadding: EdgeInsets.only(right: 10, left: 10, top: 10),
                titleChild: ListTile(
                  leading: ImageIcon(
                    AssetImage('assets/images/logo.png'),
                    size: 32,
                    color: Colors.blueAccent,
                  ),
                  title: Text(
                    'About the App',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 80,top: 12.0),
                  contentChild: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontFamily: 'Montserrat'),
                      children: [
                        TextSpan(
                          text:
                          'The process of teaching and managing a classroom had become very difficult in the times of remote working period, so as to make the process of teaching more efficient in the online environment, the application. The Web Application would help the students, teachers and the institutional heads to have easy access to all the study & course related information along with the functionalities.',
                        ),
//
                      ],
                    ),
                  ),
                ),
              ),
              GFAccordion(
//                collapsedTitlebackgroundColor: Colors.transparent,
//                expandedTitlebackgroundColor: Colors.transparent,
//                contentbackgroundColor: Colors.transparent,
              showAccordion: true,
                collapsedIcon: Text(''),
                expandedIcon: Text(''),
                titlePadding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                titleChild: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.blueAccent,
                    size: 32,
                  ),
                  title: Text(
                    'Features',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 80, right: 14,top: 12.0),
                contentChild: Column(
                  children: <Widget>[
                    RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                        children: [

                          TextSpan(
                            text:
                            'This App has various functionalites to make it easy for the teachers as well as students for managing day to day classroom activities. Some distiguished features are like dedicated Chatscreen for each course, Assignment Submission, Assignment Grading & much more!'
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              GFAccordion(
//                collapsedTitlebackgroundColor: Colors.transparent,
//                expandedTitlebackgroundColor: Colors.transparent,
//                contentbackgroundColor: Colors.transparent,
              showAccordion: true,
                collapsedIcon: Text(''),
                expandedIcon: Text(''),
                titlePadding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                  top: 12.0
                ),
                titleChild: ListTile(
                  leading: Icon(
                    Icons.settings_ethernet,
                    color: Colors.blueAccent,
                    size: 32,
                  ),
                  title: Text(
                    'Contributors',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26),
                  ),
                ),
                contentPadding: EdgeInsets.only(left: 80),
                contentChild: Column(
                  children: <Widget>[
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
                        window.open(
                           'https://github.com/singhalpranav22' ,
                            'new tab');
                      },
//                          launch('https://github.com/singhalpranav22'),
                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Pranav Singhal (IIT2019050)',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor:  Colors.blueAccent,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: NetworkImage(
                                'https://avatars2.githubusercontent.com/u/51447798'),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        window.open(
                            'https://github.com/RAJ-SHEKHAWAT' ,
                            'new tab');
                      },

                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Rajpal Singh Shekhawat (IIT2019061)',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor: Colors.blueAccent,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: NetworkImage(
                                'https://avatars.githubusercontent.com/u/73692917?v=4'),
                          ),
                        ),
                      ),
                    ),

                    FlatButton(
                      onPressed: () {
                        window.open(
                            'https://github.com/SlokAks' ,
                            'new tab');
                      },

                      padding: EdgeInsets.zero,
                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Slok Aks (IIT2019067)',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor:Colors.blueAccent,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: NetworkImage(
                                'https://avatars.githubusercontent.com/u/22662104?v=4'),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: (){
    window.open(
    'https://github.com/phantom654' ,
    'new tab');
    },

                      child: GFListTile(
                        padding: EdgeInsets.only(
                            right: 8, left: 0, bottom: 10, top: 10),
                        margin: EdgeInsets.all(0),
                        title: Text(
                          'Sumit Kumar Sahu (IIT2019069)',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        avatar: GFAvatar(
                          backgroundColor: Colors.blueAccent,
                          size: GFSize.MEDIUM + 2,
                          child: GFAvatar(
                            backgroundImage: NetworkImage(
                                'https://avatars.githubusercontent.com/u/58073775?v=4'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
