import 'dart:async';
import 'dart:typed_data';

import 'package:classroom_management/screens/HomeScreen.dart';
import 'package:classroom_management/screens/home.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
  GlobalKey<FormFieldState<String>>();
  String _name = '';
  String _phoneNumber = '';
  String _address = '';
  DateTime selectedDate = DateTime.now();
  TextEditingController cname = new TextEditingController();
  TextEditingController cphoneNumber = new TextEditingController();
  TextEditingController caddress = new TextEditingController();
  getData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await users.doc(user.uid).get();
    setState(() {
      // print(documentSnapshot.data()['name']);
      if (documentSnapshot.data()['name'] != null) {
        cname.text = documentSnapshot.data()['name'];
        _name = documentSnapshot.data()['name'];
      }
      // print(_name);
      if (documentSnapshot.data()['address'] != null) {
        caddress.text = documentSnapshot.data()['address'];
        _address = documentSnapshot.data()['address'];
      }
      if (documentSnapshot.data()['contact'] != null) {
        cphoneNumber.text = documentSnapshot.data()['contact'];
        _phoneNumber = documentSnapshot.data()['contact'];
      }
    });
  }

  setData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User user = FirebaseAuth.instance.currentUser;
    await users.doc(user.uid).update({
      'name': _name,
      'contact': _phoneNumber,
      'address': _address,
      'dob': selectedDate,
    });
    SnackBar snackBar = SnackBar(
        content: Text('Profile Updated Successfully! Returning to Home.....'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
  }

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
  String userFileName = "";
  String userGrade = "";

  storeToFirestore(String url, String fileName) async {
    try {
      CollectionReference users =
      FirebaseFirestore.instance.collection('users');
      User user = FirebaseAuth.instance.currentUser;
      await users.doc(user.uid).update({"url": url, "fileName": fileName});
    } catch (e) {
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Upload(fileName, Uint8List data) async {
    setState(() => _loadingPath = true);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('usersdata/${user.uid}/profilepic/${fileName}');
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
      SnackBar(content: Text("Uploading Your Profile Pic......."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Upload(fileName, data);
    });
  }

  String _validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1985),
        lastDate: DateTime(2031));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  bool isImgload=true;
  Widget profilePicture;
  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;

    profilePicture = CircularProgressIndicator();

    getData();

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // User user = FirebaseAuth.instance.currentUser;

    users.doc(user.uid).get().then((user) {
      String urll = user['url'];
      print(urll);
      this.setState(() {
        profilePicture = CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(urll),
        );
      });
    });

    // firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit Profile",
      ).build(context),
      body: Container(
        color: Color(0xFFF7F7F7),
        child: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Container()),
                  Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        )),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 24.0),
                          // "Name" form.
                          Center(
                            // child: Text('EDIT PROFILE',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w600,
                            //     fontSize: 25,
                            //   ),
                            // ),
                            child: profilePicture,
                          ),
                          const SizedBox(height: 24.0),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            controller: cname,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.person),
                              hintText: 'What do people call you?',
                              labelText: 'Name *',
                            ),
                            onSaved: (String value) {
                              this._name = value;
                              print('name=$_name');
                            },
                            onChanged: (String value) {
                              this._name = value;
                              print('name=$_name');
                            },
                            validator: _validateName,
                          ),
                          const SizedBox(height: 24.0),
                          // "Phone number" form.
                          TextFormField(
                            controller: cphoneNumber,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.phone),
                              hintText: 'Where can we reach you?',
                              labelText: 'Phone Number *',
                              prefixText: '+91',
                            ),
                            keyboardType: TextInputType.phone,
                            onSaved: (String value) {
                              this._phoneNumber = value;
                              print('phoneNumber=$_phoneNumber');
                            },
                            onChanged: (String value) {
                              this._phoneNumber = value;
                              print('phoneNumber=$_phoneNumber');
                            },
                            // TextInputFormatters are applied in sequence.
                          ),
                          const SizedBox(height: 24.0),
                          TextFormField(
                            controller: caddress,
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon:
                              Icon(Icons.home_outlined, color: Colors.grey),
                              hintText: 'What do people call you?',
                              labelText: 'Address *',
                            ),
                            onSaved: (String value) {
                              this._address = value;
                              print('address=$_address');
                            },
                            onChanged: (String value) {
                              this._address = value;
                            },
                            validator: _validateName,
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            children: [
                              Icon(
                                Icons.upload_rounded,
                                  color: Colors.grey
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.grey[200],
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "upload profile pic",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.date_range,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  )),
                              Expanded(
                                flex: 10,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        color: Color(0xFFFAFAFA),
                                        child: Column(
                                          children: [
                                            Text('Date of Birth'),
                                            Text("${selectedDate.toLocal()}"
                                                .split(' ')[0]),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: RaisedButton(
                                  onPressed: () => _selectDate(context),
                                  child: Text('Select date'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24.0),
                          RaisedButton(
                            onPressed: () => setData(),
                            child: Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )),
                      )),
                  Expanded(flex: 2, child: Container()),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}