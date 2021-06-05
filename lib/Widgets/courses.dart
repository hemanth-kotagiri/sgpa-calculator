import 'package:flutter/material.dart';
import 'package:sgpa_calc/Widgets/NavBar.dart';
import 'package:sgpa_calc/constants.dart';
import 'BuildCourses.dart';

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
                    height: 70,
                    color: Colors.amber[300],
                    child: Center(
                      child: ListTile(
                        title: Center(
                          child: Text(
                            "$key",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
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
