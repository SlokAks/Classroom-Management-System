import 'package:classroom_management/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:classroom_management/constants.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseAuth loggedinuser;

var now=DateTime.now().millisecondsSinceEpoch;
class AssignmentComments extends StatefulWidget {
  static String id="chat_screen";
  String title = "";
  String courseId="";
  String AssignmentId="";
  AssignmentComments({this.courseId,this.AssignmentId,this.title});
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}
String emaill;

class _CommentsScreenState extends State<AssignmentComments> {

  TextEditingController textEditingController=TextEditingController();

  @override
  void initState() {
    getCurresntuser();

    super.initState();
  }
  String message;
  final _store=FirebaseFirestore.instance;
  final _auth=FirebaseAuth.instance;

  void getCurresntuser() async
  {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        emaill = user.email.toString();
        print(emaill);
      }
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
         appBar: CustomAppBar(title: widget.title + " Class Comments" ,).build(context),
         body: Container(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: <Widget>[

               StreamBuilder<QuerySnapshot>(

                 stream: _store.collection('Courses').doc(widget.courseId).collection("Assignments").doc(widget.AssignmentId).collection("comments").snapshots(),
                 builder: (context,snapshot){
                   List<Bubble> messageWidget=[];
                   if(snapshot.hasData)
                   {

                     for(var message in snapshot.data.docs.reversed)
                     {
                       final messtext=message.data()['text'];
                       final sentby=message.data()['sender'];
                       final t=message.data()['time'];
                       final pt=message.data()['ptime'];
                       final yo=DateTime.now();
                       Bubble ans=Bubble(text: messtext,sender: sentby,isme:
                       (emaill==sentby)?true:false,time: t,yo: yo,pt: pt);

                       messageWidget.add(ans);

                     }

                     messageWidget.sort((a,b) => b.time.compareTo(a.time));



                   }
                   return Expanded(
                     child: ListView(
                       reverse: true,
                       children: messageWidget,
                     ),
                   )
                   ;
                 },
               )
               ,Container(
                 decoration: kMessageContainerDecoration,
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: <Widget>[
                     Expanded(
                       child: TextField(

                         controller: textEditingController,

                         style: TextStyle(
                           color: Colors.black,
                           fontWeight: FontWeight.bold,
                         ),
                         onChanged: (value) {
                           //Do something with the user input.
                           message=value;
                           print(message);

                         },
                         decoration:InputDecoration(
                           contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                           hintText: 'Type your message here...',
                           hintStyle: TextStyle(
                             color: Colors.black38,
                           ),
                           border: InputBorder.none,
                         ),
                       ),
                     ),
                     FlatButton(
                       onPressed: () async {

                         if(message.isEmpty)
                         {
                           textEditingController.clear();
                           return;
                         }
                         //Implement send functionality.
                         if(message!=""){
                           now=DateTime.now().millisecondsSinceEpoch;
                           final date=DateTime.now().toString().substring(0,16);
                           final a=await  _store.collection('Courses').doc(widget.courseId).collection("Assignments").doc(widget.AssignmentId).collection("comments").add({
                             'text':message,
                             'sender':emaill.toString(),
                             'time':now,
                             'ptime':date,




                           });

                           // call this method when desired

                           textEditingController.clear();
                         }


                       },
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(
                           'Send',
                           style: kSendButtonTextStyle,
                         ),
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           ),
         ),
       );

  }
}

class Bubble extends StatelessWidget {
  @override

  Bubble({this.text,this.sender,this.isme,this.time,this.yo,this.pt});
  String text;
  String sender;
  int time;
  bool isme;
  final pt;
  final yo;
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isme?CrossAxisAlignment.end:CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              pt,style: TextStyle(
              color: Colors.black,
              fontSize: 9.0,

            ),
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              isme?"You":sender,style: TextStyle(
              color: Colors.green,

            ),
            ),

          ),
          Material(
            elevation: 5.0,
            borderRadius: isme?BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)):
            BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),bottomRight:Radius.circular(30.0)),
            color: isme?Colors.white:Colors.lightBlueAccent,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    text,style: TextStyle(
                    color: isme?Colors.black:Colors.white,
                    fontSize: 20.0,

                  ),
                  ),

                ),


              ],
            ),


          ),
          SizedBox(
            height: 15.0,
          )
        ],
      ),);

  }
}