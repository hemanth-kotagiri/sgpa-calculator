import 'package:flutter/material.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';

import 'NewResultsPage.dart';
import 'ResultsPageWidget.dart';

class NewResultsFetcherWidget extends StatefulWidget {
  const NewResultsFetcherWidget({
    Key key,
    @required Map<String, dynamic> data,
  })  : _result = data,
        super(key: key);

  // this _result object consists of all the data regarding the tapped exam
  final Map<String, dynamic> _result;
  @override
  _NewResultsFetcherWidgetState createState() =>
      _NewResultsFetcherWidgetState();
}

class _NewResultsFetcherWidgetState extends State<NewResultsFetcherWidget> {
  //String _hallticket;
  //String _dob;
  //String _year;

  TextEditingController _hallticketController = TextEditingController();
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget._result.values.elementAt(0), // Exam name
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.green[200],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Hallticket Number",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _hallticketController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _hallticketController.text = "";
                    },
                  ),
                  labelText: "Hallticket",
                  hintText: "Enter Here",
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: ElevatedButton(
                    onPressed: _isPressed == false
                        ? () async {
                            if (_hallticketController.text == "") {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      // backgroundColor: Colors.blueAccent,
                                      title: Center(
                                        child: Text(
                                            "Please provide valid input only."),
                                      ),
                                    );
                                  });
                            }
                            ResultFetcher fetcher = ResultFetcher(
                              hallticket: _hallticketController.text,
                              dob: "",
                              year: "",
                            );
                            setState(() {
                              _isPressed = true;
                            });
                            List result;
                            try {
                              String degree = widget._result["degree"];
                              String examCode = widget._result["examCode"];
                              String eType = widget._result["etype"];
                              String type = widget._result["type"];
                              String paramResult =
                                  widget._result["result"] == null
                                      ? ''
                                      : widget._result["result"];

                              if (widget._result["exam_name"]
                                  .contains("Supplementary")) {
                                result = await fetcher.fetchSupplyResult(
                                  hallticket: _hallticketController.text,
                                  dob: "3",
                                  degree: degree,
                                  examCode: examCode,
                                  eType: eType,
                                  result: paramResult,
                                  type: type,
                                );
                              } else {
                                result = await fetcher.fetchRegularResults(
                                  hallticket: _hallticketController.text,
                                  dob: "3",
                                  degree: degree,
                                  examCode: examCode,
                                  eType: eType,
                                  result: paramResult,
                                  type: type,
                                );
                              }
                            } on FormatException {
                              setState(() {
                                _isPressed = false;
                              });
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Sorry, Something went wrong with server! Please try again!"),
                                    );
                                  });
                            } catch (Exception) {
                              print(Exception);
                              setState(() {
                                _isPressed = false;
                              });
                              return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    // backgroundColor: Colors.blueAccent,
                                    title: Text(
                                      "Please provide valid input only.",
                                    ),
                                  );
                                },
                              );
                            }
                            _resultsPage(result);
                          }
                        : null,
                    child: Text(
                      "Get Result",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  _resultsPage(List<dynamic> result) {
    setState(() {
      _isPressed = false;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "RESULT",
            style: TextStyle(color: Colors.cyan),
          ),
          centerTitle: true,
        ),
        body: widget._result["exam_name"].contains("Supplementary")
            ? NewResultsPage(result: result)
            : ResultsPage(
                result: result,
              ),
      );
    }));
  }
}
