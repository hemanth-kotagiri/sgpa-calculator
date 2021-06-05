import 'package:flutter/material.dart';
import 'package:sgpa_calc/constants.dart';

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
          child: Text(
            "Calculate",
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        )
      ],
    );
  }
}
