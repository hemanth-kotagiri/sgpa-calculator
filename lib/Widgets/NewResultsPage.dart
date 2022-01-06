import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewResultsPage extends StatefulWidget {
  const NewResultsPage({
    Key key,
    @required List<dynamic> result,
  })  : _result = result,
        super(key: key);

  final List<dynamic> _result;

  @override
  _NewResultsPageState createState() => _NewResultsPageState();
}

class _NewResultsPageState extends State<NewResultsPage> {
  @override
  Widget build(BuildContext context) {
    List _subjects = widget._result.elementAt(1);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          ListTile(
            // Name
            leading: Icon(
              Icons.confirmation_num,
              color: Colors.amber[200],
            ),
            title: Text("${widget._result.elementAt(0).keys.elementAt(0)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                )),
            subtitle: SelectableText(
              "${widget._result.elementAt(0).values.elementAt(0)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),
          ListTile(
            // Name
            leading: Icon(
              Icons.vpn_key,
              color: Colors.amber[200],
            ),
            title: Text("${widget._result.elementAt(0).keys.elementAt(3)}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                )),
            subtitle: SelectableText(
                "${widget._result.elementAt(0).values.elementAt(3)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.amber[200],
            ),
            // Name
            title: Text("${widget._result.elementAt(0).keys.elementAt(1)}",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                )),
            subtitle: SelectableText(
                "${widget._result.elementAt(0).values.elementAt(1)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.family_restroom,
              color: Colors.amber[200],
            ),
            // Name
            title: Text("${widget._result.elementAt(0).keys.elementAt(2)}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                )),
            subtitle: SelectableText(
                "${widget._result.elementAt(0).values.elementAt(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Divider(
            thickness: 1.0,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _subjects.length,
            itemBuilder: (BuildContext context, int index) {
              Map _currentSubject = _subjects[index];

              String subjectCode = _currentSubject.values.elementAt(0);
              String subjectName = _currentSubject.values.elementAt(1);
              String gradeEarned = _currentSubject.values.elementAt(2);
              String subjectCredits = _currentSubject.values.elementAt(3);
              bool hasAdditionInfo = _currentSubject.length > 4;
              Color subjectColor;
              Color gradeColor;
              if (gradeEarned == "F" || gradeEarned == "Ab") {
                gradeColor = Colors.red;
                subjectColor = Colors.red[300];
              } else {
                gradeColor = Colors.green;
                subjectColor = Colors.blue[100];
              }
              return Column(
                children: [
                  ListTile(
                    title: SelectableText(
                      "$subjectName",
                      style: TextStyle(
                        color: subjectColor,
                      ),
                    ),
                    subtitle: SelectableText(
                      "Credits : $subjectCredits",
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    leading: Column(
                      children: [
                        SelectableText("$subjectCode",
                            style: TextStyle(color: Colors.amber[200])),
                      ],
                    ),
                    trailing: Column(
                      children: [
                        SelectableText(
                          "$gradeEarned",
                          style: TextStyle(fontSize: 18, color: gradeColor),
                        ),
                        additionInfo(hasAdditionInfo, _currentSubject)
                      ],
                    ),
                  ),
                  Divider(thickness: 1.0),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

Widget additionInfo(bool hasAdditionInfo, Map currentSubject) {
  String internalMarks, externalMarks;
  if (hasAdditionInfo) {
    // Addition Information
    internalMarks = currentSubject.values.elementAt(4);
    externalMarks = currentSubject.values.elementAt(5);
    return Column(
      children: [
        SelectableText(
          "I : $internalMarks",
        ),
        SelectableText(
          "E : $externalMarks",
        ),
      ],
    );
  }
  // Null Widget
  return SizedBox.shrink();
}
