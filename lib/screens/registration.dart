import 'dart:async';

import 'package:classroom_management/screens/HomeScreen.dart';
import 'package:classroom_management/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Registration extends StatefulWidget {
  const Registration({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  saveUserInfoToFireStore() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (!documentSnapshot.exists) {
      users.doc(user.uid).set({
        "id": user.uid,
        "name": this._name,
        "email": this._email,
        "contact": this._phoneNumber,
        "isProf": false,
        "isdisabled": false,
        "isAdmin": false,
      });
    }
  }

  String _name;
  String _phoneNumber;
  String _email;
  String _password;

  String _validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
    return null;
  }

  String _validaterePass(String value) {
    if (rePass.text != this._password) return "Password doesn't match!";
    return null;
  }

  register() async {
    bool done = true;
    print(this._email);
    print(this._password);
    if (this._name == null ||
        this._email == null ||
        this._phoneNumber == null) {
      SnackBar snackBar = SnackBar(content: Text("Enter all Fields correctly"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (rePass.text != this._password) {
      SnackBar snackBar = SnackBar(content: Text("Passwords doesn't match !"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: this._email,
        password: this._password,
      );
    } on FirebaseAuthException catch (e) {
      done = false;
      SnackBar snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Timer(Duration(seconds: 3), () {});
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    if (done) {
      saveUserInfoToFireStore();
      SnackBar snackBar = SnackBar(
          content: Text("Successfuly Registered! Logging you in....."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      });
    }
  }

  TextEditingController rePass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Registration             ").build(context),
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
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                          // borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Please enter your info",
                                style: TextStyle(
                                  // fontSize: 92.0,
                                  color: Color(0xFFD427A4),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    const SizedBox(height: 24.0),
                                    // "Name" form.
                                    TextFormField(
                                      textCapitalization:
                                          TextCapitalization.words,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.person),
                                        //hintText: 'What do people call you?',
                                        labelText: 'Name *',
                                      ),
                                      onChanged: (String value) {
                                        this._name = value;
                                      },
                                      onSaved: (String value) {
                                        this._name = value;
                                        print('name=$_name');
                                      },
                                      validator: _validateName,
                                    ),
                                    const SizedBox(height: 24.0),
                                    // "Phone number" form.
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.phone),
                                        //hintText: 'Phone Number',
                                        labelText: 'Phone Number',
                                        prefixText: '+91',
                                      ),
                                      keyboardType: TextInputType.phone,
                                      onChanged: (String value) {
                                        this._phoneNumber = value;
                                      },
                                      onSaved: (String value) {
                                        this._phoneNumber = value;
                                        print('phoneNumber=$_phoneNumber');
                                      },
                                      // TextInputFormatters are applied in sequence.
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ),
                                    const SizedBox(height: 24.0),
                                    // "Email" form.
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.email),
                                        //hintText: 'Your email address',
                                        labelText: 'E-mail *',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (String value) {
                                        this._email = value;
                                      },
                                      onSaved: (String value) {
                                        this._email = value;
                                        print('email=$_email');
                                      },
                                    ),
                                    const SizedBox(height: 24.0),
                                    // "Life story" form.
                                    // const SizedBox(height: 24.0),
                                    // "Salary" form.

                                    const SizedBox(height: 24.0),
                                    // "Password" form.

//                                    PasswordField(
//                                      fieldKey: _passwordFieldKey,
//                                      helperText: 'Not more than 8 characters.',
//                                      labelText: 'Password *',
//                                      onFieldSubmitted: (String value) {
//                                        setState(() {
//                                          this._password = value;
//                                        });
//                                      },
//                                    ),
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.security),
                                        labelText:
                                            'Type password (max 8-characters)',
                                      ),
                                      maxLength: 8,
                                      obscureText: true,
                                      onChanged: (value) {
                                        this._password = value;
                                      },
                                    ),
                                    const SizedBox(height: 24.0),
                                    // "Re-type password" form.
                                    TextFormField(
                                      controller: rePass,
                                      validator: _validaterePass,
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(),
                                        filled: true,
                                        icon: Icon(Icons.security),
                                        labelText: 'Re-type password *',
                                      ),
                                      maxLength: 8,
                                      obscureText: true,
                                    ),
                                    SizedBox(
                                      height: 16.0,
                                    ),

                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: 60,
                                            height: 35,
                                            child: RaisedButton(
                                              onPressed: () {
                                                register();
                                              },
                                              elevation: 8.0,
                                              child: Center(
                                                child: Text("Register"),
                                              ),
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
      ),
    );
  }
}
