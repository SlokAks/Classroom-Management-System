import 'package:classroom_management/screens/AssignmentComments.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AssignmentView extends StatefulWidget {
  String courseId="NA";
  String title = "NA";
  String description = "NA";
  String assignmentId = "NA";
  Timestamp dueDate;
  String url="NA";
  AssignmentView({this.courseId,this.title,this.description,this.assignmentId,this.dueDate,this.url});
  @override
  _AssignmentViewState createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  bool isSubmitted=false;
  bool isLoading=true;
  User user;
  CollectionReference assignment;
  findIfSubmitted() async{
    setState(() {
      isLoading=true;
    });
    DocumentSnapshot documentSnapshot = await assignment.doc(widget.assignmentId).get();
    if(documentSnapshot.exists) {
      setState(() {
        isSubmitted=true;
      });
    }
    else{
      setState(() {
        isSubmitted=false;
      });

    }
    print('done');
    setState(() {
      isLoading=false;
    });
  }

  Future getPdfAndUpload()async{
//    var rng = new Random();
//    String randomName="";
//    for (var i = 0; i < 20; i++) {
//      print(rng.nextInt(100));
//      randomName += rng.nextInt(100).toString();
//    }

    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.custom,allowedExtensions: ['.pdf','.jpg','.png','.docx','.pptx','jpeg']);
//    String fileName = '${randomName}.pdf';
//    print(fileName);
//    print('${file.readAsBytesSync()}');
//    savePdf(file.readAsBytesSync(), fileName);
  }

//  Future savePdf(List<int> asset, String name) async {
//
//    StorageReference reference = FirebaseStorage.instance.ref().child(name);
//    StorageUploadTask uploadTask = reference.putData(asset);
//    String url = await (await uploadTask.onComplete).ref.getDownloadURL();
//    print(url);
//    documentFileUpload(url);
//    return  url;
//  }
  @override
  void initState() {
    // TODO: implement initState
    user= FirebaseAuth.instance.currentUser;
    assignment = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('enrolledCourses').doc(widget.courseId).collection('Assignments');
    findIfSubmitted();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title,).build(context),

      body: SingleChildScrollView(
        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Expanded(
                   flex: 2,
                    child: Container(
                    child: Card(
                      elevation: 14.0,
                      color: Colors.white,
                      child: Container(
                        child: Column(
                          children: [
                            Wrap(
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.book,color: Theme.of(context).accentColor,),
                                ),
                                SizedBox(width: 12.0,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(this.widget.title,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                  ),),
                                ),
                                SizedBox(width: 36.0,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Due Date : ",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                      color: Colors.red
                                  ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(this.widget.dueDate.toDate().toString(),style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                      color: Colors.black
                                  ),),
                                ),
                              ],

                            ),
                            SizedBox(height: 4.0,child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                              ),
                            ),),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(this.widget.description,style: TextStyle(
                                fontSize: 18.0,

                              ),),
                            ),
                            SizedBox(height: 2.0,child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                              ),
                            ),),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.tealAccent,
                                ),
                                onPressed: (){
                                  html.window.open(this.widget.url, 'new tab');
                                }, child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.book,color: Colors.blueAccent,),
                                ),
                                SizedBox(width: 4.0,child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                  ),
                                ),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("View : ${this.widget.title}",style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight:
                                      FontWeight.bold,
                                    color: Colors.purple,
                                  ),),
                                )
                              ],
                            )),
                            SizedBox(height: 2.0,child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                              ),
                            ),),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.tealAccent,
                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AssignmentComments(courseId: widget.courseId,AssignmentId: widget.assignmentId,title: widget.title,)));
                                }, child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.group,color: Colors.blueAccent,),
                                ),
                                SizedBox(width: 4.0,child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                  ),
                                ),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Class Comments for ${this.widget.title}",style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight:
                                    FontWeight.bold,
                                    color: Colors.purple,
                                  ),),
                                )
                              ],
                            )),
                            SizedBox(height: 2.0,child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                              ),
                            ),),
                          ],
                        ),
                      ),
                    ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Card(
                        elevation: 14.0,
                        color: Colors.white,
                        child: Container(
                          child: Column(
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.assignment,color: Theme.of(context).accentColor,),
                                  ),
                                  SizedBox(width: 12.0,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Your Work",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),),
                                  ),
                                ],

                              ),
                              SizedBox(height: 4.0,child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                ),
                              ),),
                             isLoading?Center(child: CircularProgressIndicator(),) : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: isSubmitted? Text("Submitted",style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0
                                ),) :

                                Text("Not Submitted",style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0
                                ),),
                              ),
                              isLoading?Center(child: CircularProgressIndicator(),) :
                                  isSubmitted ?  Container() :  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.lightBlueAccent,
                                      ),
                                      onPressed: (){
                                        //Todo : Implement File Submission functionality
                                        getPdfAndUpload();
//                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>AssignmentComments(courseId: widget.courseId,AssignmentId: widget.assignmentId,title: widget.title,)));
                                      }, child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.add,color: Colors.purple,),
                                      ),
                                      SizedBox(width: 4.0,child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                        ),
                                      ),),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Add Work",style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.black,
                                        ),),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 1.0,child: Container(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
            ),),

          ],

        ),
      ),
    );
  }
}
