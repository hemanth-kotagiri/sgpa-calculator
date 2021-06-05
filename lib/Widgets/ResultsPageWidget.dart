import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({
    Key key,
    @required List<dynamic> result,
  })  : _result = result,
        super(key: key);

  final List<dynamic> _result;

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    List _subjects = widget._result.elementAt(2);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "SGPA",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${widget._result.elementAt(0).values.elementAt(0)}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ),
          Divider(),
          ListTile(
            // Name
            title: Text("${widget._result.elementAt(1).keys.elementAt(0)}",
                style: TextStyle(fontSize: 18)),
            trailing: Text(
              "${widget._result.elementAt(1).values.elementAt(0)}",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(),
          ListTile(
            // Name
            title: Text("${widget._result.elementAt(1).keys.elementAt(3)}",
                style: TextStyle(fontSize: 18)),
            trailing: Text("${widget._result.elementAt(1).values.elementAt(3)}",
                style: TextStyle(fontSize: 18)),
          ),
          Divider(),
          ListTile(
            // Name
            title: Text("${widget._result.elementAt(1).keys.elementAt(1)}",
                style: TextStyle(fontSize: 18)),
            trailing: Text("${widget._result.elementAt(1).values.elementAt(1)}",
                style: TextStyle(fontSize: 18)),
          ),
          Divider(),
          ListTile(
            // Name
            title: Text("${widget._result.elementAt(1).keys.elementAt(2)}",
                style: TextStyle(fontSize: 18)),
            trailing: Text("${widget._result.elementAt(1).values.elementAt(2)}",
                style: TextStyle(fontSize: 18)),
          ),
          Divider(),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _subjects.length,
            itemBuilder: (BuildContext context, int index) {
              print(index);
              String subjectCode =
                  _subjects.elementAt(index).values.elementAt(0);
              String subjectName =
                  _subjects.elementAt(index).values.elementAt(1);
              String gradeEarned =
                  _subjects.elementAt(index).values.elementAt(2);
              String subjectCredits =
                  _subjects.elementAt(index).values.elementAt(3);
              return Column(
                children: [
                  ListTile(
                    title: Text("$subjectName"),
                    subtitle: Text("Credits : $subjectCredits"),
                    leading: Text("$subjectCode"),
                    trailing:
                        Text("$gradeEarned", style: TextStyle(fontSize: 18)),
                  ),
                  Divider()
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
