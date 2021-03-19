import 'package:classroom_management/screens/home.dart';
import 'package:classroom_management/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MaterialApp(
        theme: ThemeData(
          accentColor: Colors.lightBlueAccent,
          splashColor: Colors.greenAccent,
        ),
      home:MyApp()));
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(

      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

Scaffold SomethingWentWrong(){
  return
    Scaffold(
      appBar: AppBar(
        title: Text("Something is wrong"),
      ),
      body: Center(
        child: Container(
          child: Text("Something is wrong !"),
        ),
      ),
    );

}
Scaffold Loading(){


    return Scaffold(
      appBar: AppBar(
        title: Text("Loading"),
      ),
      body: Center(
        child: Container(
          child: circularProgress()
        ),
      ),
    );
}

