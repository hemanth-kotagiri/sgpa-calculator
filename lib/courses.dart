import 'package:flutter/material.dart';

class CoursesWidget extends StatefulWidget {
  CoursesWidget({Key key}) : super(key: key);

  @override
  _CoursesWidgetState createState() => _CoursesWidgetState();
}

class _CoursesWidgetState extends State<CoursesWidget> {
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
                  onTap: () => {_individialCoursePage()},
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
                  onTap: () => {_individialCoursePage()},
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

  _individialCoursePage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("HELLO"),
          ),
        );
      },
    ));
  }
}
