import 'package:flutter/material.dart';
import 'package:sgpa_calc/Widgets/ResultsPageWidget.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';

class ResultsFetcherWidget extends StatefulWidget {
  @override
  _ResultsFetcherWidgetState createState() => _ResultsFetcherWidgetState();
}

class _ResultsFetcherWidgetState extends State<ResultsFetcherWidget> {
  //String _hallticket;
  //String _dob;
  //String _year;

  TextEditingController _hallticketController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Fetch Results"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
                  labelText: "Hallticket",
                  hintText: "Enter Here",
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: "Year-Month-Day",
                  hintText: "Enter Here",
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Year",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: "Year,Sem",
                  hintText: "Enter Here",
                  border: OutlineInputBorder(),
                ),
              ),
              Divider(),
              ElevatedButton(
                  onPressed: _isPressed == false
                      ? () async {
                          if (_hallticketController.text == "" ||
                              _yearController.text == "" ||
                              _dobController.text == "") {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    // backgroundColor: Colors.blueAccent,
                                    title: Text("Please give valid input"),
                                  );
                                });
                          }
                          ResultFetcher fetcher = ResultFetcher(
                            hallticket: _hallticketController.text,
                            dob: _dobController.text,
                            year: _yearController.text,
                          );
                          setState(() {
                            _isPressed = true;
                          });
                          List result;
                          try {
                            result = await fetcher.fetchResult();
                          } catch (Exception) {
                            setState(() {
                              _isPressed = false;
                            });
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    // backgroundColor: Colors.blueAccent,
                                    title:
                                        Text("Please give valid input only!"),
                                  );
                                });
                          }
                          _resultsPage(result);
                        }
                      : null,
                  child: Text(
                    "Get Result",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ))
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
        body: ResultsPage(
          result: result,
        ),
      );
    }));
  }
}
