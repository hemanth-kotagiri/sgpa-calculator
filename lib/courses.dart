import 'package:flutter/material.dart';
import 'package:sgpa_calc/NavBar.dart';

class CoursesWidget extends StatefulWidget {
  CoursesWidget({Key key}) : super(key: key);

  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  final _grades = <String>["O", "A+", "A", "B+", "B", "C", "F"];
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
              colors: [Colors.teal, Colors.red],
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
      drawer: NavBar(),
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
        body: BuildCoursesList(grades: _grades, courses: courses),
      );
    }));
  }
}

class BuildCoursesList extends StatefulWidget {
  const BuildCoursesList({
    Key key,
    @required List<String> grades,
    @required this.courses,
  })  : _grades = grades,
        super(key: key);

  final List<String> _grades;
  final Map<String, num> courses;

  @override
  _BuildCoursesListState createState() => _BuildCoursesListState();
}

class _BuildCoursesListState extends State<BuildCoursesList> {
  List<String> defaultValues = ["F", "F", "F", "F", "F", "F", "F", "F"];

  alertGPA(BuildContext context) {
    // Calculate the grade
    double totalCreditsGained = 0;
    double creditDenomination = 0;

    for (var i = 0; i < widget.courses.length; i++) {
      double currentCredit = widget.courses.values.elementAt(i).toDouble();

      creditDenomination += currentCredit;

      totalCreditsGained += currentCredit * _gradeScores[defaultValues[i]];
    }

    double gpa =
        num.parse((totalCreditsGained / creditDenomination).toStringAsFixed(2));
    // Render the pop-up here
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Your SGPA is : $gpa"),
          );
        });
  }

  final _gradeScores = {
    "O": 10,
    "A+": 9,
    "A": 8,
    "B+": 7,
    "B": 6,
    "C": 5,
    "F": 0,
  };

  @override
  Widget build(BuildContext context) {
    // print(courses);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.courses.length,
            itemBuilder: (BuildContext context, int index) {
              String key = widget.courses.keys.elementAt(index);
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text("$key"),
                    subtitle: Text("Credits: ${widget.courses[key]}"),
                    trailing: DropdownButton(
                      value: defaultValues[index],
                      items: widget._grades.map((String grade) {
                        return DropdownMenuItem<String>(
                          value: grade,
                          child: Text(grade),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          defaultValues[index] = newValue;
                        });
                      },
                    ),
                  ),
                  Divider(
                    height: 10.0,
                  ),
                ],
              );
            },
          ),
        ),
        TextButton(
          onPressed: () {
            alertGPA(context);
          },
          child: Text("Calculate"),
        )
      ],
    );
  }
}
