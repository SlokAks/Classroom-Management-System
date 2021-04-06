import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RemoveProf extends StatefulWidget {
  @override
  _RemoveProfState createState() => _RemoveProfState();
}

class _RemoveProfState extends State<RemoveProf> {
  CollectionReference userRef=FirebaseFirestore.instance.collection("users");
  remProf(String id){
    setState(() async{
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.doc(id).update({
        "isdisabled":true,
      });
    });
  }
  @override
  void initState(){
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REMOVE PROFESSOR'),
      ),
      body:Container(
        child: StreamBuilder(
            stream: userRef.snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              return ListView(
                children: snapshot.data.docs.map(
                      (document) {

                    if(!document["isdisabled"]&&document["isProf"]) {
                      return
                        Container(
                          child: Column(
                            children: [
                              Text(document["name"]),
                              Text(document["email"]),
                              Text(document["contact"]),
                              RaisedButton(
                                child: Text('REMOVE'),
                                onPressed: () {
                                  remProf(document["id"]);
                                },
                              ),
                            ],
                          ),
                        );
                    }
                    else{
                      return Container();
                    }
                  },
                ).toList(),
              );
            }),
      ),
    );
  }
}
