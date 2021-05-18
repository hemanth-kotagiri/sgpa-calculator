import 'package:flutter/material.dart';

class CoursesWidget extends StatefulWidget {
  CoursesWidget({Key key}) : super(key: key);

  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  final _eceCourse = {
    "Microprocessors & Microcontrollers": 4,
    "Control Systems": 4,
    "Business Economics & Financial Analysis": 3,
    "Professional Elective": 3,
    "Microprocessors & Microcontrollers lab": 1.5,
    "Data Communications and Networks lab": 1.5,
    "Advanced Communication Skills Lab": 1
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

  _individialCoursePage(Map<String, num> courses) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("SGPA Calculator"),
          centerTitle: true,
        ),
        body: _buildCoursesList(courses),
        persistentFooterButtons: [
          Row(
            children: [
              TextButton(
                child: Text("Calculate"),
                onPressed: () {},
              )
            ],
          )
        ],
      );
    }));
  }

  Widget _buildCoursesList(Map<String, num> courses) {
    print(courses);
    final _grades = <String>["O", "A+", "A", "B+", "B", "C", "F"];
    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (BuildContext context, int index) {
        String key = courses.keys.elementAt(index);
        return Column(
          children: <Widget>[
            ListTile(
              title: Text("$key"),
              subtitle: Text("Credits: ${courses[key]}"),
              trailing: DropdownButton<String>(
                value: "F",
                items: _grades.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
            Divider(
              height: 10.0,
            ),
          ],
        );
      },
    );
    // return Column(
    //   children: <Widget>[Text("Hello")],
    // );
  }
}
