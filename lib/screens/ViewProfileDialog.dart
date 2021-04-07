import 'package:classroom_management/screens/HomeScreen.dart';
import 'package:classroom_management/screens/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewProflieDialog extends StatefulWidget {
  @override
  _ViewProflieDialogState createState() => _ViewProflieDialogState();
}


class _ViewProflieDialogState extends State<ViewProflieDialog> {

  @override
  String urll;
  Widget profilePicture;
  Widget name;
  Widget email;
  Widget address;
  Widget dob;
  Widget contact;
  String cname;
  String cemail;
  String caddress;
  String cdob;
  String ccontact;

  @override
  void initState() {
    // TODO: implement initState

    User user = FirebaseAuth.instance.currentUser;
    name=Text('....NA.....');
    contact=Text('.........');
    email=Text('loading.....');
    dob=Text('loading.....');
    address=Text('loading.....');
    profilePicture = CircleAvatar(
      child: Icon(
        Icons.person,
        color: Colors.blue,
      ),
    );

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(user.uid).get().then((dataa) {
      if (dataa.data().containsKey('contact')) {
        if (dataa['contact'] != null) {
          ccontact = dataa['contact'];
          setState(() {
            contact = Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Contact : ' + ccontact,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                ),
              ),
            );
          });
        }
        else {
          setState(() {
            contact = Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Contact : -',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                ),
              ),
            );
          });
        }
      }
      if (dataa.data().containsKey('email')) {
        if (dataa['email'] != null) {
          cemail = dataa['email'];
          setState(() {
            email = Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Email : ' + cemail,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                ),
              ),
            );
          });
        }
        else {
          setState(() {
            email = Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Email : -',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                ),
              ),
            );
          });
        }
      }
      if (dataa.data().containsKey('name')) {
        if (dataa['name'] != null) {
          cname = dataa['name'];
          setState(() {
            name = Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Name : ' + cname,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                ),
              ),
            );
          });
        }
        else {
          setState(() {
            name = Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Name : -',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                ),
              ),
            );
          });
        }
      }
      if (dataa.data().containsKey('address')) {
        if (dataa['address'] != null) {
          caddress = dataa['address'];
          setState(() {
            address = Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Address: ' + caddress,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                ),

              ),
            );
          });
        }
        else {
          setState(() {
            address = Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Address: -',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w200
                ),

              ),
            );
          });
        }
      }
      if (dataa.data().containsKey('dob')) {
        if (dataa['dob'] != null) {
          DateTime date = dataa['dob'].toDate();
          cdob = date.year.toString() + '-' + date.month.toString() + '-' +
              date.day.toString();
          setState(() {
            dob = Text('D.O.B :' + cdob,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              ),
              softWrap: true,
            );
          });
        }
        else {
          setState(() {
            dob = Text('D.O.B : -',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              ),
              softWrap: true,
            );
          });
        }
      }
      if (dataa.data().containsKey('url')) {
        if (dataa['url'] != null) {
          urll = dataa['url'];
          this.setState(() {
            profilePicture = CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(urll),
            );
          });
        }
      }
    });


    super.initState();
  }
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap:(){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
            Expanded(
                flex: 1,
                child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(child: profilePicture),
                            SizedBox(height: 20),
                            name,
                            SizedBox(height: 20),
                            email,
                            SizedBox(height: 20),
                            contact,
                            SizedBox(height: 20),
                            dob,
                            SizedBox(height: 20),
                            address,
                            SizedBox(height: 20),

                            GestureDetector(
                              onTap:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => EditProfile()));
                            },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.blue,
                                    ),
                                    child: Text('EDIT PROFILE',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
