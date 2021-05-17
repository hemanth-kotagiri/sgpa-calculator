import 'package:flutter/material.dart';

class CoursesWidget extends StatefulWidget {
  CoursesWidget({Key key}) : super(key: key);

  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  final _eceCourse = {
    "EC501PC - Microprocessors & Microcontrollers": 4,
    "Control Systems": 4,
    "Business Economics & Financial Analysis": 3,
    "Professional Elective": 3,
    "Microprocessors & Microcontrollers lab": 1.5,
    "Data Communications and Networks lab": 1.5,
    "Advanced Communication Skills Lab": 1

// 2 EC502PC Data Communications and Networks 3 1 0 4
// 3 EC503PC Control Systems 3 1 0 4
// 4 SM504MS Business Economics & Financial Analysis 3 0 0 3
// 5 Professional Elective - I 3 0 0 3
// 6 EC505PC Microprocessors & Microcontrollers Lab 0 0 3 1.5
// 7 EC506PC Data Communications and Networks Lab 0 0 3 1.5
// 8 EN508HS Advanced Communication Skills Lab 0 0 2 1
  };

  final _cseCourse = {
    "Formal Languages and Automata Theory": 3,
    "Software Engineering": 3,
    "Computer Networks": 3,
    "Professional Elective 1": 3,
    "Professional Elective 2": 3,
    "Software Engineering Lab": 1.5,
    "Computer Networks and Web Technologies Lab": 1.5,
    "Advanced Communication Skills Lab": 1
  };
  Widget _renderBranches() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.red],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              // padding: const EdgeInsets.all(8),
              height: 100,
              color: Colors.amber[500],
              child: Center(
                child: ListTile(
                  title: Center(
                      child: Text("Electronics and Communication Engineering")),
                  onTap: () => {_individialCoursePage(_eceCourse)},
                ),
              )),
          Container(
              margin: EdgeInsets.all(20),
              padding: const EdgeInsets.all(11),
              height: 100,
              color: Colors.amber[500],
              child: Center(
                child: ListTile(
                  title:
                      Center(child: Text("Computer Science and Engineering")),
                  onTap: () => {_individialCoursePage(_cseCourse)},
                ),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SGPA Calculator"),
        centerTitle: true,
      ),
      body: Center(
        child: _renderBranches(),
      ),
    );
  }

  _individialCoursePage(courses) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              title: Text("SGPA Calculator"),
              centerTitle: true,
            ),
            body: _buildCoursesList(courses));
      },
    ));
  }

  Widget _buildCoursesList(courses) {
    // print(courses);
    final tiles = [];

    courses.forEach((k, v) => {
          tiles.add(ListTile(
            title: Text("KEY : $k and Value : $v"),
          ))
        });

    // final divided =
    //     ListTile.divideTiles(context: context, tiles: tiles).toList();

    // final divided = tiles.isNotEmpty
    //     ? ListTile.divideTiles(context: context, tiles: tiles).toList()
    //     : <Widget>[];

    return Column(
      children: tiles,
    );
  }
}
