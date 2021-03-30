import 'package:classroom_management/screens/course.dart';
import 'package:classroom_management/widgets/navbar.dart';
import 'package:flutter/material.dart';

class CourseDescription extends StatelessWidget {
  String courseId;
  String title = "NA";
  String description = "NA";
  CourseDescription(this.courseId, {this.title, this.description});
  @override
  Widget build(BuildContext context) {
    print(courseId);
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: const Icon(Icons.tag_faces),
        title: Center(child: Text("Course Description")),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xFFAD70FA), Color(0xFF8857DF)])),
        ),
        actions: <Widget>[
          // GestureDetector(
          //   onTap: () {
          //     // Navigator.push(context,
          //     //     MaterialPageRoute(builder: (context) => AvailableCourses()));
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) {
          //           return AvailableCoursesDialog();
          //         });
          //   },
          //   child: IconButton(
          //     icon: const Icon(
          //       Icons.add,
          //       color: Colors.blue,
          //     ),
          //     //TODO onpressed
          //   ),
          // ),
          IconButton(
            icon: const Icon(Icons.account_circle_sharp),
            //TODO onpressed
          ),
          // PopupMenuButton(
          //   itemBuilder: (BuildContext context) {
          //     return [
          //       const PopupMenuItem(child: Text('Boat')),
          //       const PopupMenuItem(child: Text('Train'))
          //     ];
          //   },
          // )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: Text(
                  "Course Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 44.0),
                ),
              ),
            ),
          ),
          Divider(),
          Expanded(
            flex: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              child: Column(
                children: [
                  Text(
                    "Name of the Course :    " + title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 28.0,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 28.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Course(
                            courseId,
                            title: title,
                            description: description,
                          )),
                );
              },
              child: Container(
                height: 130.0,
                width: 450.0,
                child: Card(
                  elevation: 14.0,
                  child: Container(
                    height: 130.0,
                    decoration: BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: Center(
                      child: Text(
                        "Go to Course Page",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
