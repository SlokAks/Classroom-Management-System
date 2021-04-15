import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// String pid;


class ChooseCourse extends StatefulWidget {

  String profID;
  ChooseCourse(this.profID);
  @override
  _ChooseCourseState createState() => _ChooseCourseState();
}
class _ChooseCourseState extends State<ChooseCourse> {
  CollectionReference courseRef=FirebaseFirestore.instance.collection("Courses");
  @override
   Widget messageToShow=Container();
  addcourse(String PID,String CID)async{
    CollectionReference user=FirebaseFirestore.instance.collection("users");
    await user
        .doc(PID).collection("CoursesTeaching").doc(CID)
        .set({});
    setState(() {
      messageToShow=Container(
        child: Text('Course $CID has been Added Successfully!',
        style: TextStyle(
          color: Colors.green,
          fontSize: 20,
          fontWeight: FontWeight.w400
        ),),
      );
    });
  }


  Widget build(BuildContext context) {
    String pid=widget.profID;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          Expanded(
            flex: 2,
              child: Container(color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  Center(child: messageToShow),
                ],
              ),)),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),

              child: StreamBuilder(
                  stream: courseRef.snapshots(),
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

                          if(!document["isdisabled"])
                          {
                            return
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      // padding: EdgeInsets.all(20),
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Divider(color: Colors.white,),
                                          Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[700],
                                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                                              ),
                                              child: Text(document["name"]+'( '+document.id+' )')),
                                          Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                              ),
                                              child: Text(document["description"])),
                                          // Container(
                                          //
                                          //     child: Text(document.id)),
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                addcourse(pid,document.id);
                                              },
                                              child: Center(child: Text('ADD',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              )),

                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
          ),
        ],
      ),
    );
  }
}
