import 'dart:html';
import 'dart:typed_data';

import 'package:classroom_management/screens/AssignmentComments.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AssignmentView extends StatefulWidget {
  String courseId = "NA";
  String title = "NA";
  String description = "NA";
  String assignmentId = "NA";
  Timestamp dueDate;
  String url = "NA";
  AssignmentView(
      {this.courseId,
      this.title,
      this.description,
      this.assignmentId,
      this.dueDate,
      this.url});
  @override
  _AssignmentViewState createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  bool isSubmitted = false;
  bool isLoading;
  User user;
  bool _loadingPath = false;
  List<PlatformFile> _paths;
  FileType _pickingType = FileType.any;
  String _directoryPath;
  String fileName;
  bool isLate = false;
  String _extension;
  bool _multiPick = false;
  String userAssignmentUrl = "";
  Timestamp userSubmissionTime;
  String userFileName = "";
  String userGrade = "";
  CollectionReference assignment;
  findIfSubmitted() async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot documentSnapshot =
        await assignment.doc(widget.assignmentId).get();
    if (documentSnapshot.exists) {
      setState(() {
        userSubmissionTime = documentSnapshot.data()['submittedAt'];
        userAssignmentUrl = documentSnapshot.data()['url'];
        userGrade = documentSnapshot.data()['grade'];
        userFileName = documentSnapshot.data()['fileName'];
        if (userSubmissionTime.toDate().isBefore(widget.dueDate.toDate())) {
          isLate = false;
        } else {
          isLate = true;
        }
        isSubmitted = true;
      });
    } else {
      setState(() {
        isSubmitted = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  storeToFirestore(String url, String fileName) async {
    try {
      await assignment.doc(widget.assignmentId).set({
        "submittedAt": DateTime.now(),
        "url": url,
        "grade": "",
        "fileName": fileName
      });
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AssignmentView(
                  title: this.widget.title,
                  description: this.widget.description,
                  courseId: this.widget.courseId,
                  assignmentId: this.widget.assignmentId,
                  dueDate: this.widget.dueDate,
                  url: this.widget.url)));
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Upload(fileName, Uint8List data) async {
    setState(() => _loadingPath = true);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref(
        'usersdata/${user.uid}/${widget.courseId}/${widget.assignmentId}/${fileName}');
    _extension = fileName.toString().split('.').last;
    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
            contentType: '$_pickingType/$_extension');

    try {
      await ref.putData(data, metadata);
      String downloadURL = await ref.getDownloadURL();
      print(downloadURL);
      storeToFirestore(downloadURL, fileName);
      setState(() {
        _loadingPath = false;
      });
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
    }
  }

  Future getFileAndUpload() async {
    try {
      _directoryPath = null;
      _paths = (await FilePicker.platform.pickFiles(
        type: _pickingType,
        allowMultiple: _multiPick,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      _loadingPath = false;

      _paths != null ? _paths.map((e) => fileName = e.name).toString() : '...';
      List<int> bytes;
      _paths != null ? _paths.map((e) => {bytes = e.bytes}).toString() : '...';

      Uint8List data = Uint8List.fromList(bytes);
      SnackBar snackBar =
          SnackBar(content: Text("Uploading Your Assignment......."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Upload(fileName, data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    assignment = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('enrolledCourses')
        .doc(widget.courseId)
        .collection('Assignments');
    findIfSubmitted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
      ).build(context),
      body: SingleChildScrollView(
        child: _loadingPath
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                                          child: Icon(
                                            Icons.book,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            this.widget.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 36.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Due Date : ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24.0,
                                                color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            this
                                                .widget
                                                .dueDate
                                                .toDate()
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 24.0,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          this.widget.description,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.tealAccent,
                                        ),
                                        onPressed: () {
                                          window.open(
                                              this.widget.url, 'new tab');
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.book,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "View : ${this.widget.title}",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    SizedBox(
                                      height: 2.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.tealAccent,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AssignmentComments(
                                                        courseId:
                                                            widget.courseId,
                                                        AssignmentId:
                                                            widget.assignmentId,
                                                        title: widget.title,
                                                      )));
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Icon(
                                                Icons.group,
                                                color: Colors.blueAccent,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4.0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Class Comments for ${this.widget.title}",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                    SizedBox(
                                      height: 2.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
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
                                          child: Icon(
                                            Icons.assignment,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 12.0,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Your Work",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.purple,
                                        ),
                                      ),
                                    ),
                                    isLoading
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : (isSubmitted
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      isLate
                                                          ? "Submitted Late!"
                                                          : "Submitted",
                                                      style: TextStyle(
                                                          color: isLate
                                                              ? Colors.red
                                                              : Colors.green,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.0),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Text(
                                                      "Submitted at : ${userSubmissionTime.toDate()} ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.0),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2.0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Colors.tealAccent,
                                                      ),
                                                      onPressed: () {
                                                        window.open(
                                                            userAssignmentUrl,
                                                            'new tab');
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .file_download,
                                                              color: Colors
                                                                  .blueAccent,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .purple,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 4.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3.0),
                                                                  child: Text(
                                                                    "Download Your Submission",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .purple,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3.0),
                                                                  child: Text(
                                                                    "(${userFileName})",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .purple,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    height: 2.0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                      onPressed: () {},
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.grade,
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .purple,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 4.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              userGrade == ""
                                                                  ? "Not Yet Graded!"
                                                                  : "Grade : ${userGrade}",
                                                              style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 2.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .purple,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    height: 2.0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                      onPressed: () {
                                                        getFileAndUpload();
//
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.restore,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 4.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Submit a Different File",
                                                              style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    height: 2.0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Not Submitted",
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.0),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors
                                                            .lightBlueAccent,
                                                      ),
                                                      onPressed: () {
                                                        //Todo : Implement File Submission functionality
//                                        getPdfAndUpload();
                                                        getFileAndUpload();
//                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>AssignmentComments(courseId: widget.courseId,AssignmentId: widget.assignmentId,title: widget.title,)));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.purple,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 4.0,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .yellow,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Add Work",
                                                              style: TextStyle(
                                                                fontSize: 18.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                  SizedBox(
                                                    height: 2.0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.purple,
                                                      ),
                                                    ),
                                                  ),
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
                  SizedBox(
                    height: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
