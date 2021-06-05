import 'package:flutter/material.dart';
import 'Widgets/ResultsFetcherWidget.dart';
import 'Widgets/courses.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity(horizontal: 2.0, vertical: 2.0),
        primaryColorLight: Color(0xff03203C),
        primaryColorDark: Color(0xff242B2E),
      ),
      home: ResultsFetcherWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
