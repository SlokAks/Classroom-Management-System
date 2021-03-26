import 'dart:async';

import 'package:classroom_management/screens/HomeScreen.dart';
import 'package:classroom_management/screens/home.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
  GlobalKey<FormFieldState<String>>();
  String _name='';
  String _phoneNumber='';
  String _address='';
  DateTime selectedDate = DateTime.now();
  TextEditingController cname = new TextEditingController();
  TextEditingController cphoneNumber = new TextEditingController();
  TextEditingController caddress = new TextEditingController();
  getData()async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await users.doc(user.uid).get();
    setState(() {
      // print(documentSnapshot.data()['name']);
      if(documentSnapshot.data()['name']!=null) {
        cname.text = documentSnapshot.data()['name'];
        _name=documentSnapshot.data()['name'];
      }
      // print(_name);
      if(documentSnapshot.data()['address']!=null) {
        caddress.text = documentSnapshot.data()['address'];
        _address=documentSnapshot.data()['address'];
      }
      if(documentSnapshot.data()['contact']!=null) {
        cphoneNumber.text = documentSnapshot.data()['contact'];
        _phoneNumber = documentSnapshot.data()['contact'];
      }
    });
  }
  setData()async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User user = FirebaseAuth.instance.currentUser;
    await users.doc(user.uid).update({
      'name':_name,
      'contact':_phoneNumber,
      'address':_address,
      'dob':selectedDate,
    });
    SnackBar snackBar= SnackBar(content: Text('Profile Updated Successfully! Returning to Home.....'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Timer(
        Duration(seconds: 3),(){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) =>HomePage()));
    }
    );
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
  @override
  void initState() {
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile",).build(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 24.0),
            // "Name" form.
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
                icon: Icon(Icons.home_outlined),
                hintText: 'What do people call you?',
                labelText: 'Address *',
              ),
              onSaved: (String value) {
                this._address = value;
                print('address=$_address');
              },
              onChanged: (String value){
                this._address=value;
              },
              validator: _validateName,
            ),
            const SizedBox(height: 24.0),
            Text("${selectedDate.toLocal()}".split(' ')[0]),
            SizedBox(height: 20.0,),
            RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
            const SizedBox(height: 24.0),
            RaisedButton(
              onPressed: () => setData(),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

