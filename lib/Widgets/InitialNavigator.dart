import 'package:flutter/material.dart';

class InitialNavigator extends StatefulWidget {
  @override
  _InitialNavigatorState createState() => _InitialNavigatorState();
}

class _InitialNavigatorState extends State<InitialNavigator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("SGPA Calculator"),
            centerTitle: true,
        ),
        body: Center(
            Container(
                child: ListTile(
                    title: Text("Hello"),
                ),
            );
        ),
    );
  }
}
