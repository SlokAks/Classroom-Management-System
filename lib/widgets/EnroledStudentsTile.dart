import 'package:classroom_management/screens/ViewStudentProfile.dart';
import 'package:flutter/material.dart';
import 'package:classroom_management/models/user.dart';
class EnroledStudentTile extends StatelessWidget {
  CurrentUser curUser;
  EnroledStudentTile({this.curUser});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              // color: Color(0xFFE095F7),
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text(
                    curUser.name,
                    style: TextStyle(
                      // color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProflie(uid: curUser.id,)));
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 5,
                  ),
                  child: Text("View Student"),
                ),

                ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                    shadowColor: Colors.red,
                    elevation: 5,
                  ),
                  child: Text("Student Profile"),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: Color(0xFFEEEEEE)
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              child: Text(curUser.email)),
        ],
      ),
    );
  }
}
