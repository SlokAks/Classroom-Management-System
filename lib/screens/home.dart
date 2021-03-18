import 'package:classroom_management/screens/AvailableCourses.dart';
import 'package:classroom_management/screens/EnroledCourse.dart';
import 'package:classroom_management/screens/assignments.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final GoogleSignIn gSignIn = GoogleSignIn();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSigned = false;
  controlSignIn(GoogleSignInAccount googleSignInAccount) async {
    if (googleSignInAccount != null) {
      setState(() {
        print(googleSignInAccount.displayName);
        isSigned = true;
      });
    } else {
      setState(() {
        isSigned = false;
      });
    }
  }

  loginUser() {
    gSignIn.signIn();
  }

  logoutUser() {
    gSignIn.signOut();
  }

  login() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    setState(() {
      isSigned = true;
    });
  }

  MaterialApp buildSignInScreen() {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColor
              ])),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Classroom System",
                style: TextStyle(
                  fontSize: 92.0,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Button Pressed");
                  login();
                  setState(() {
                    isSigned = true;
                  });
                },
                child: Container(
                  width: 270.0,
                  height: 65.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("assets/images/google_signin_button.png"),
                    fit: BoxFit.cover,
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initState() {
    // TODO: implement initState
    gSignIn.onCurrentUserChanged.listen((gSigninAccount) {
      controlSignIn(gSigninAccount);
    }, onError: (error) {
      print("Error Occured : " + error.toString());
    });
    gSignIn.signInSilently(suppressErrors: false).then((gSigninAccount) {
      controlSignIn(gSigninAccount);
    }).onError((error, stackTrace) {
      print("Error : " + error);
    });
  }

  Scaffold buldHomeScreen() {
    return
       Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: Center(
            child: ListView(
          children: [
            Row(
              children: [
                Container(
                  height: 260.0,
                  width: 580.0,
                  child: Card(
                    elevation: 14.0,
                    child: Container(
                      height: 230.0,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                      ),
                      child: Column(

                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: Icon(
                                Icons.person
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Name : ",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),),
                              Text("Raju Rastogi",style: TextStyle(
                                fontSize: 26.0,
                              ),),
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Semeseter : ",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),),
                              Text("4",style: TextStyle(
                                fontSize: 26.0,
                              ),),
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Contact : ",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),),
                              Text("9999999999",style: TextStyle(
                                fontSize: 26.0,
                              ),),

                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Branch : ",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),),
                              Text("I.T.",style: TextStyle(
                                fontSize: 26.0,
                              ),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AvailableCourses()),
                        );
                      },
                      child: Container(
                        height: 130.0,
                        width: 450.0,
                        child: Card(
                          elevation: 14.0,
                          child: Container(
                            height: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                            ),
                            child: Center(
                              child: Text("Available Courses",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EnroledCourses()),
                        );
                      },
                      child: Container(
                        height: 130.0,
                        width: 450.0,
                        child: Card(
                          elevation: 14.0,
                          child: Container(
                            height: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                            ),
                            child: Center(
                              child: Text("Enroled Courses",style: TextStyle(
                              fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Assignments()),
                        );
                      },
                      child: Container(
                        height: 130.0,
                        width: 400.0,
                        child: Card(
                          elevation: 14.0,
                          child: Container(
                            height: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                            ),
                            child: Center(
                              child: Text("Assignments",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: 130.0,
                        width: 400.0,
                        child: Card(
                          elevation: 14.0,
                          child: Container(
                            height: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                            ),
                            child: Center(
                              child: Text("Edit Profile",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),

              ],
            )
          ],
        )),
      );

  }

  @override
  Widget build(BuildContext context) {
    if (isSigned) {
      return buldHomeScreen();
    } else {
      return buildSignInScreen();
    }
  }
}
