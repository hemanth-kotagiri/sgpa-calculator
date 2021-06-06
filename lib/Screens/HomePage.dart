import 'package:flutter/material.dart';
import 'package:sgpa_calc/Widgets/courses.dart';
import 'package:sgpa_calc/Widgets/ResultsFetcherWidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SGPA Calculator"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                Text("Hello, Widget 1"),
                Text("Hello, Widget 2"),
              ],
            ),
          ),
        ));
  }
}
