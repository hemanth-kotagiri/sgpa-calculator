import 'package:flutter/material.dart';
import 'package:sgpa_calc/Widgets/courses.dart';
import 'package:sgpa_calc/Widgets/ResultsFetcherWidget.dart';
import 'package:sgpa_calc/Widgets/NavBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "SGPA Calculator",
            style: TextStyle(color: Colors.cyan),
          ),
          centerTitle: true,
        ),
        drawer: NavBar(),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(35),
                  height: 70,
                  color: Colors.amber[300],
                  child: Center(
                    child: ListTile(
                      title: Center(
                        child: Text(
                          "Previous Year Results Fetcher",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onTap: () => {_changePageToFetcher(context)},
                    ),
                  ),
                ),
                Divider(
                  thickness: 1.8,
                  //indent: 50,
                  //endIndent: 50,
                ),
                Container(
                  margin: EdgeInsets.all(35),
                  height: 70,
                  color: Colors.amber[300],
                  child: Center(
                    child: ListTile(
                      title: Center(
                        child: Text(
                          "3,1 Calculator",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      onTap: () => {_changePageToCalculator(context)},
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  _changePageToFetcher(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ResultsFetcherWidget();
        },
      ),
    );
  }

  _changePageToCalculator(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return CoursesWidget();
        },
      ),
    );
  }
}
