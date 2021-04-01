import 'dart:async';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:classroom_management/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
class AddAssignment extends StatefulWidget {
  String courseId="NA";
  AddAssignment({this.courseId});
  @override
  _AddAssignmentState createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  String title = '';
  String description = '';
  DateTime dueDate = DateTime.now();
  TimeOfDay dueTime=TimeOfDay.now();
  String url="";
  bool _loadingPath = false;
  List<PlatformFile> _paths;
  FileType _pickingType = FileType.any;
  String _directoryPath;
  String fileName;
  bool isLate = false;
  String _extension;
  bool _multiPick = false;
  bool isUploaded=false;
  bool isSubmitting=false;
  String errMessage="";
  TextEditingController tTitle = new TextEditingController();
  TextEditingController tDesc = new TextEditingController();
  String _validate(String value) {
    if (value.isEmpty) return 'Field cannot be Empty';
    return null;
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dueDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2031));
    if (picked != null && picked != dueDate)
      setState(() {
        dueDate = picked;
      });
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
       initialTime: dueTime
    );
    if (picked != null && picked != dueDate)
      setState(() {
        dueTime = picked;
      });
  }
   submit() async{
   if(title=="" || url=="" || description==""){
     setState(() {
       errMessage="Error : Add all fields!";
     });
     return;
   }
   setState(() {
     isSubmitting=true;
   });
   CollectionReference assignment = FirebaseFirestore.instance.collection('Courses').doc(widget.courseId).collection("Assignments");
   bool wasSuccess=true;
   try{
   assignment.add({
     "title" : title,
     "Description" : description,
     "dueDate" : DateTime(dueDate.year,dueDate.month, dueDate.day, dueTime.hour, dueTime.minute),
     "link" :url
   });}
   catch(e){
     wasSuccess=false;
     setState(() {
       errMessage=e.toString();
       isSubmitting=false;
     });
   }
   if(wasSuccess){
     setState(() {
       isSubmitting=false;
     });
     SnackBar snackBar = SnackBar(content: Text("Assignment ${title} submitted Successfully!"));
     ScaffoldMessenger.of(context).showSnackBar(snackBar);
     Timer(Duration(seconds: 3), () {
       Navigator.pop(context);
     });
   }

   }
  Upload(fileName, Uint8List data) async {
    setState(() => _loadingPath = true);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('coursedata/${widget.courseId}/${fileName}');
    _extension = fileName.toString().split('.').last;
    firebase_storage.SettableMetadata metadata =
    firebase_storage.SettableMetadata(
        contentType: '$_pickingType/$_extension');

    try {
      await ref.putData(data, metadata);
      String downloadURL = await ref.getDownloadURL();
      print(downloadURL);
      setState(() {
        url=downloadURL;
        _loadingPath = false;
        isUploaded=true;
      });
    } catch (e) {
      setState(() {
        url="";
      });
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
      SnackBar(content: Text("Uploading Assignment....."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Upload(fileName, data);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Assignment for ${widget.courseId} Course",
      ).build(context),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Card(
          elevation: 14.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Color(0xFFF7F7F7),

             child: Container(
               // color: Colors.white,
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.only(
                     topRight: Radius.circular(20),
                     topLeft: Radius.circular(20),
                   )),
               child: SingleChildScrollView(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: <Widget>[
                     const SizedBox(height: 24.0),
                     TextFormField(
                       keyboardType: TextInputType.multiline,
                       maxLines: null,
                       textCapitalization: TextCapitalization.words,
                       controller: tTitle,
                       decoration: const InputDecoration(
                         border: UnderlineInputBorder(),
                         filled: true,
                         icon: Icon(Icons.title,color: Colors.purple,),
                         hintText: 'Give Title to the Assignment',
                         labelText: 'Title',
                       ),
                       onSaved: (String value) {
                         this.title = value;
                       },
                       onChanged: (String value) {
                         this.title = value;
                       },
                       validator: _validate,
                     ),
                     const SizedBox(height: 24.0),
                     // "Phone number" form.
                     TextFormField(
                       keyboardType: TextInputType.multiline,
                       maxLines: null,
                       controller: tDesc,
                       decoration: const InputDecoration(
                         border: UnderlineInputBorder(),
                         filled: true,
                         icon: Icon(Icons.description,color: Colors.purple),
                         hintText: 'Add Assignment Description',
                         labelText: 'Description',
                       ),
                       onSaved: (String value) {
                         this.description = value;
                       },
                       onChanged: (String value) {
                         this.description = value;
                       },
                       // TextInputFormatters are applied in sequence.
                     ),
                     const SizedBox(height: 24.0),
                     Wrap(
                       direction: Axis.horizontal,
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Expanded(
                               flex: 1,
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Icon(
                                     Icons.date_range,
                                     color: Colors.purple,
                                   ),
                                 ],
                               )),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Expanded(
                             flex: 10,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Container(
                                     color: Color(0xFFFAFAFA),
                                     child: Column(
                                       children: [
                                         Text('Due Date'),
                                         Text("${dueDate.toLocal()}"
                                             .split(' ')[0]),
                                       ],
                                     )),
                               ],
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Expanded(
                             flex: 10,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Container(
                                     color: Color(0xFFFAFAFA),
                                     child: Column(
                                       children: [
                                         Text('Due Time'),
                                         Text("${dueTime.hour}:${dueTime.minute}"
                                             .split(' ')[0]),
                                       ],
                                     )),
                               ],
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Expanded(
                             flex: 3,
                             child: RaisedButton(
                               onPressed: () => _selectDate(context),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text('Select Due date'),
                               ),
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Expanded(
                             flex: 3,
                             child: RaisedButton(
                               onPressed: () => _selectTime(context),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text('Select Due Time'),
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                     const SizedBox(height: 24.0),
                  _loadingPath? Center(child: CircularProgressIndicator(),) :  Row(
                       children: [
                         Icon(
                             Icons.upload_rounded,
                             color: Colors.purple
                         ),
                         SizedBox(
                           width: 15,
                         ),
                        isUploaded?Text("File Uploaded Successfully.Now Submit it!") : ElevatedButton(
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
                                     "Upload Assignment",
                                     style: TextStyle(
                                       fontSize: 18.0,
                                       color: Colors.black,
                                     ),
                                   ),
                                 )
                               ],
                             )),
                       ],
                     ),
                     const SizedBox(height: 24.0),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: RaisedButton(
                         onPressed: () => submit(),
                         child: isSubmitting? CircularProgressIndicator():Text('Submit'),
                       ),
                     ),
                     const SizedBox(height: 24.0),
                     Center(
                       child: Text(errMessage,style: TextStyle(color: Colors.red),),
                     )
                   ],
                 ),
               ),
             ),





            ),
          ),
        ),
      ),
    );
  }
}
