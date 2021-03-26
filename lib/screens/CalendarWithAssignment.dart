import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWithAssignment extends StatefulWidget {
  @override
  _CalendarWithAssignment createState() => _CalendarWithAssignment();
}

class _CalendarWithAssignment extends State<CalendarWithAssignment>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    _events = {
      DateTime(1999, 1, 1): [
        ['Event A0', 'Event B0']
      ],
    };

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _selectedEvents = _events[DateTime(
            _selectedDay.year, _selectedDay.month, _selectedDay.day)] ??
        [];

    _animationController.forward();
    _calendarController = CalendarController();
    getEvents();
    super.initState();
  }

  void getEvents() {
    User currentUserr = FirebaseAuth.instance.currentUser;
    CollectionReference enrolledCoursesReference = FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserr.uid)
        .collection("enrolledCourses");
    enrolledCoursesReference.get().then((courseSnapshot) {
      courseSnapshot.docs.forEach((enrolledCourse) {
        CollectionReference assignmentsReference = enrolledCoursesReference
            .doc(enrolledCourse.id)
            .collection("Assignments");
        assignmentsReference.get().then((assignmentSnapshot) {
          assignmentSnapshot.docs.forEach((assignment) {
            FirebaseFirestore.instance
                .collection("Courses")
                .doc(enrolledCourse.id)
                .collection("Assignments")
                .doc(assignment.id)
                .get()
                .then((value) {
              print(assignment.id);
              String title = value['title'];
              Timestamp dueDate = value['dueDate'];

              if (_events.containsKey(DateTime(dueDate.toDate().year,
                  dueDate.toDate().month, dueDate.toDate().day))) {
                print("ho");
                _events[DateTime(dueDate.toDate().year, dueDate.toDate().month,
                        dueDate.toDate().day)]
                    .add([title, enrolledCourse.id]);
              } else {
                _events.addAll({
                  DateTime(dueDate.toDate().year, dueDate.toDate().month,
                      dueDate.toDate().day): [
                    [title, enrolledCourse.id]
                  ]
                });
              }
              setState(() {
                DateTime now = DateTime.now();
                _selectedEvents =
                    _events[DateTime(now.year, now.month, now.day)] ?? [];
                // print(_selectedEvents.toString());
              });
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_buildTableCalendar(), Expanded(child: _buildEventList())],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      rowHeight: 70,
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)

  Widget _buildEventList() {
    return ListView(
      children: _selectedEvents
          .map((event) => Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Column(
                  children: [
                    Text(event[1].toString()),
                    Text(event[0].toString()),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
