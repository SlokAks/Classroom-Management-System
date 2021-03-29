import 'package:classroom_management/models/user.dart';
import 'package:classroom_management/screens/AvailableCourses.dart';
import 'package:classroom_management/screens/EnroledCourse.dart';
import 'package:classroom_management/screens/assignments.dart';
import 'package:classroom_management/screens/registration.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'HomeScreen.dart';

final GoogleSignIn gSignIn = GoogleSignIn();
FirebaseAuth auth = FirebaseAuth.instance;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSigned = false;
  String _email;
  String _password;
  bool isLoading = false;
  String error = "";
  CurrentUser currentUser;
  String name = "";
  String email = "";
  String contact = "";

  isLoggedIn() {
    auth.authStateChanges().listen((User user) async {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isSigned = false;
        });
        return;
      } else {
        User user = FirebaseAuth.instance.currentUser;

//      if (!user.emailVerified) {
//        await user.sendEmailVerification();
//        SignOut();
//        return;
//      }
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        currentUser = CurrentUser.fromDocument(documentSnapshot);
        print(user.uid);
        print('User is signed in!');
        setState(() {
          name = currentUser.name;
          email = currentUser.email;
          contact = currentUser.contact;
          isSigned = true;
        });
      }
    });
  }

  SignIn() async {
    bool done = true;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: this._email,
        password: this._password,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.toString();
      });
      done = false;

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    if (done) {
      User user = FirebaseAuth.instance.currentUser;

//      if (!user.emailVerified) {
//        await user.sendEmailVerification();
//        SignOut();
//        return;
//      }
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      currentUser = CurrentUser.fromDocument(documentSnapshot);
      setState(() {
        name = currentUser.name;
        email = currentUser.email;
        contact = currentUser.contact;
        isSigned = true;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  SignOut() async {
    SnackBar snackBar = SnackBar(content: Text("Signing Out......"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    await FirebaseAuth.instance.signOut();
  }

  MaterialApp buildSignInScreen() {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFD427A4),
                    Color(0xFF20BBAA),
                  ]),
            )),
            Column(
              children: [
                // Expanded(flex: 1,
                //   child: Container(),
                // ),
                Expanded(
                  flex: 10,
                  child: Container(
                    alignment: Alignment.center,
                    // child: Image.asset('images/thumbnail/thumbnail.png',
                    //   // fit: BoxFit.fill,
                    //
                    // ),
                  ),
                ),
                // Expanded(flex: 1,
                //   child: Container(),
                // ),
              ],
            ),
            // Container(color: Colors.white.withOpacity(0.5),),
            Container(
              child: Column(
                children: [
                  Container(
                    child: Expanded(
                      flex: 1,
                      child: Container(
                          // color: Colors.white.withOpacity(0.9),
                          // child: Text(
                          //   "Classroom System",
                          //   style: TextStyle(
                          //     fontSize: 92.0,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          ),
                    ),
                  ),
                  Expanded(
                      flex: 10,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              // color: Colors.white.withOpacity(0.9),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(10),
                                // borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: SingleChildScrollView(
                                //padding: const EdgeInsets.symmetric(horizontal: 60.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Expanded(
                                    //       flex: 1,
                                    //       child: Image(
                                    //       image: AssetImage('assets/images/logoo.png'),
                                    //     ),
                                    //     ),
                                    //
                                    //     Expanded(
                                    //       flex: 2,
                                    //       child: Text(
                                    //       "Classroom System",
                                    //       textAlign: TextAlign.center,
                                    //       style: TextStyle(
                                    //       fontSize: 85.0,
                                    //       color: Color(0xFFD427A4),
                                    //     ),),),
                                    //   ],
                                    // ),
                                    //

                                    Image(
                                        image: AssetImage('assets/images/logooCropp.png'),
                                     ),


                                    Text(
                                      "Classroom System",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 85.0,
                                        color: Color(0xFFD427A4),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 100.0,  //60
                                          top: 30.0,
                                          right: 100.0, //60
                                          bottom: 10.0),

                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          filled: true,
                                          fillColor: Colors.white70,
                                          focusColor: Colors.grey,
                                          icon: Icon(Icons.person),
                                          // hintText: 'Your email address',
                                          labelText: 'User ID (Email)',
                                        ),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onChanged: (String value) {
                                          this._email = value;
                                        },
                                        onSaved: (String value) {
                                          this._email = value;
                                          print('email=$_email');
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 100.0, //60.0,
                                          top: 30.0,
                                          right: 100.0, //60.0
                                          bottom: 30.0),

                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: UnderlineInputBorder(),
                                          filled: true,
                                          icon: Icon(Icons.lock),
                                          fillColor: Colors.white70,
                                          focusColor: Colors.grey,
                                          //hintText: 'Password',
                                          labelText: 'Password',
                                        ),
                                        obscureText: true,
                                        onChanged: (String value) {
                                          this._password = value;
                                        },
                                      ),
                                    ),

                                    Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(),
                                      ),

                                      Expanded(
                                        flex: 3,
                                          child:GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                isLoading = true;
                                              });

                                              SignIn();

                                              isLoggedIn();
                                            },
                                            child: Card(
                                              elevation: 5.0, //14.0,
                                              color: Colors.white.withOpacity(0.0),
                                              child: Container(
                                                width: 80.0, //150.0,
                                                height: 40.0, //60.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10), //20
                                                  color: Theme.of(context).accentColor, //Colors.greenAccent,
                                                ),
                                                child: Center(
                                                  child: Text("Login"),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Container(),
                                      ),

                                      Expanded(
                                        flex: 3,
                                          child:GestureDetector(
                                            onTap: () {
                                              print("Button Pressed");
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TextFormFieldExample()));
//                  login();
                                              isLoggedIn();
                                            },
                                            child: Card(
                                              elevation: 5.0, //14.0,
                                              color: Colors.white.withOpacity(0.0),
                                              child: Container(
                                                width: 80.0, //150.0,
                                                height: 40.0, //60.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  color: Theme.of(context).accentColor,
                                                ),
                                                child: Center(
                                                  child: Text("New User ? Register"),
                                                ),
                                              ),
                                            ),
                                          ),

                                      ),

                                      Expanded(
                                        flex: 2,
                                        child: Container(),
                                      ),

                                    ],
                                    ),



                                    isLoading
                                        ? circularProgress()
                                        : Container(
                                            child: Center(
                                              child: Text(
                                                error,
                                                style: (TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.red,
                                                )),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(),
                          ),
                        ],
                      )),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
            Container(
                // child: CircleAvatar(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                      // child: Image.asset('images/logoo.png',
                      // fit: BoxFit.fill,
                      // ),
                      ),
                ),
                Expanded(flex: 2, child: Container())
              ],
            )
                // ),
                ),
            Container(
//            height: MediaQuery.of(context).size.height,
//            width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
              // gradient: LinearGradient(
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //     colors: [
              //   Theme.of(context).accentColor,
              //   Theme.of(context).primaryColor
              // ]
              //   )
              // ),
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // children: [
                    //   Text(
                    //     "Classroom System",
                    //     style: TextStyle(
                    //       fontSize: 92.0,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   SizedBox(
                    //     height: 26.0,
                    //   ),
                    //   Text(
                    //     "Login",
                    //     style: TextStyle(
                    //       fontSize: 70.0,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       filled: true,
                    //       fillColor: Colors.white70,
                    //       focusColor: Colors.grey,
                    //       icon: Icon(Icons.email),
                    //       hintText: 'Your email address',
                    //       labelText: 'E-mail',
                    //     ),
                    //     keyboardType: TextInputType.emailAddress,
                    //     onChanged: (String value) {
                    //       this._email = value;
                    //     },
                    //     onSaved: (String value) {
                    //       this._email = value;
                    //       print('email=$_email');
                    //     },
                    //   ),
                    // ),
                    // const SizedBox(height: 24.0),
                    // "Password" form.
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     decoration: const InputDecoration(
                    //       border: UnderlineInputBorder(),
                    //       filled: true,
                    //       icon: Icon(Icons.keyboard),
                    //       fillColor: Colors.white70,
                    //       focusColor: Colors.grey,
                    //       hintText: 'Password',
                    //       labelText: 'Shhh... Password here!',
                    //     ),
                    //     obscureText: true,
                    //     onChanged: (String value) {
                    //       this._password = value;
                    //     },
                    //   ),
                    // ),

//                     const SizedBox(height: 24.0),
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           isLoading = true;
//                         });
//
//                         SignIn();
//
//                         isLoggedIn();
//                       },
//                       child: Card(
//                         elevation: 14.0,
//                         child: Container(
//                           width: 150.0,
//                           height: 60.0,
//                           decoration: BoxDecoration(
//                             color: Colors.greenAccent,
//                           ),
//                           child: Center(
//                             child: Text("Login"),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 24.0),
//                     GestureDetector(
//                       onTap: () {
//                         print("Button Pressed");
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => TextFormFieldExample()));
// //                  login();
//                         isLoggedIn();
//                       },
//                       child: Card(
//                         elevation: 14.0,
//                         child: Container(
//                           width: 150.0,
//                           height: 60.0,
//                           decoration: BoxDecoration(
//                             color: Colors.greenAccent,
//                           ),
//                           child: Center(
//                             child: Text("New User ? Regester"),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 12.0,
//                     ),
//                     isLoading
//                         ? circularProgress()
//                         : Container(
//                             child: Center(
//                               child: Text(
//                                 error,
//                                 style: (TextStyle(
//                                   fontSize: 18.0,
//                                   color: Colors.red,
//                                 )),
//                               ),
//                             ),
//                           )
//                   ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initState() {
    // TODO: implement initState

    isLoggedIn();

    super.initState();
  }

  Stack buldHomeScreen() {
    return Stack(
      children: [
        Image.asset(
          "assets/images/iiita.jpg",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          drawer: NavDrawer(),
          appBar: AppBar(
            title: Text("Home Page"),
          ),
          body: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Card(
                    color: Colors.white.withOpacity(0.7),
                    elevation: 14.0,
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Name : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                              ),
                              Text(
                                name == null ? "" : name,
                                style: TextStyle(
                                  fontSize: 26.0,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Contact : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                              ),
                              Text(
                                contact == null ? "" : contact,
                                style: TextStyle(
                                  fontSize: 26.0,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Email : ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                              ),
                              Text(
                                email == null ? "" : email,
                                style: TextStyle(
                                  fontSize: 26.0,
                                ),
                              ),
                            ],
                          ),
//                          Divider(),
//                          Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.center,
//                            children: [
//                              Text("Branch : ",style: TextStyle(
//                                fontWeight: FontWeight.bold,
//                                fontSize: 26.0,
//                              ),),
//                              Text("I.T.",style: TextStyle(
//                                fontSize: 26.0,
//                              ),),
//                            ],
//                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AvailableCourses()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Card(
                          color: Colors.white.withOpacity(0.7),
                          elevation: 14.0,
                          child: Container(
                            height: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                "Available Courses",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EnroledCourses()),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Card(
                        color: Colors.white.withOpacity(0.7),
                        elevation: 14.0,
                        child: Container(
                          height: 130.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "Enroled Courses",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Assignments()),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Card(
                          color: Colors.white.withOpacity(0.7),
                          elevation: 14.0,
                          child: Container(
                            height: 130.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                "Assignments",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Card(
                        elevation: 14.0,
                        color: Colors.white.withOpacity(0.7),
                        child: Container(
                          height: 130.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              )),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isSigned) {
      return HomeScreen(name, context);
    } else {
      return buildSignInScreen();
    }
  }
}
