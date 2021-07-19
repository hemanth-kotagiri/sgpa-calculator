import 'package:flutter/material.dart';
import 'package:sgpa_calc/Widgets/ResultsPageWidget.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';
import 'package:sgpa_calc/Widgets/NavBar.dart';

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
        title: Text("Fetch Results",
            style: TextStyle(
              color: Colors.cyan,
            )),
        centerTitle: true,
      ),
      drawer: NavBar(),
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
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear_sharp),
                    onPressed: () {
                      _dobController.text = "";
                    },
                  ),
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
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear_sharp),
                    onPressed: () {
                      _yearController.text = "";
                    },
                  ),
                  labelText: "Year,Sem",
                  hintText: "1,1",
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: ElevatedButton(
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
                                      title: Center(
                                        child: Text(
                                            "Please provide valid input only."),
                                      ),
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
                            } on FormatException {
                              setState(() {
                                _isPressed = false;
                              });
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Sorry, Something wrong with Server! Will be fixed shortly!"),
                                    );
                                  });
                            } catch (Exception) {
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
        body: ResultsPage(
          result: result,
        ),
      );
    }));
  }
}
