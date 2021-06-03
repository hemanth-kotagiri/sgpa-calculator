import 'package:flutter/material.dart';
import 'package:sgpa_calc/NavBar.dart';
import 'constants.dart';

class CoursesWidget extends StatefulWidget {
  CoursesWidget({Key key}) : super(key: key);

  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
  Widget _renderBranches() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: branchCourses.length,
              itemBuilder: (BuildContext context, int index) {
                String key = branchCourses.keys.elementAt(index);
                return Container(
                    margin: EdgeInsets.all(20),
                    height: 100,
                    color: Colors.amber[300],
                    child: Center(
                      child: ListTile(
                        title: Center(
                            child: Text(
                          "$key",
                          style: TextStyle(color: Colors.black),
                        )),
                        onTap: () => {
                          _individialCoursePage(
                              branchCourses.values.elementAt(index))
                        },
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          "SGPA Calculator",
          style: TextStyle(color: Colors.cyan),
        ),
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
          title: Text(
            "SGPA Calculator for 3,1",
            style: TextStyle(color: Colors.cyan),
          ),
          centerTitle: true,
        ),
        body: BuildCoursesList(grades: grades, courses: courses),
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
  List<String> defaultValues = ["F", "F", "F", "F", "F", "F", "F", "F", "F"];
  Widget _alertText;
  Widget _content;

  alertGPA(BuildContext context) {
    // Calculate the grade
    double totalCreditsGained = 0;
    double creditDenomination = 0;

    for (var i = 0; i < widget.courses.length; i++) {
      double currentCredit = widget.courses.values.elementAt(i).toDouble();

      creditDenomination += currentCredit;

      if (gradeScores[defaultValues[i]] == 0) {
        totalCreditsGained = 0;
        break;
      }
      totalCreditsGained += currentCredit * gradeScores[defaultValues[i]];
    }

    double gpa =
        num.parse((totalCreditsGained / creditDenomination).toStringAsFixed(2));
    if (gpa != 0) {
      _alertText = Center(
          child: Text(
        "PASS",
        style: TextStyle(
          color: Colors.green,
        ),
      ));
      _content = Text("Calculated SGPA: $gpa");
    } else {
      _alertText = Center(
        child: Text(
          "FAIL",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
      _content = Text("Sorry, better luck next time. Don't give up!");
    }
    // Render the pop-up here
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // backgroundColor: Colors.blueAccent,
            title: _alertText,
            content: _content,
          );
        });
  }

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
                    subtitle: Text(
                      "Credits: ${widget.courses[key]}",
                      style: TextStyle(color: Colors.green),
                    ),
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
                          print(defaultValues);
                        });
                      },
                    ),
                  ),
                  Divider(
                    height: 10.0,
                    thickness: 1.0,
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
