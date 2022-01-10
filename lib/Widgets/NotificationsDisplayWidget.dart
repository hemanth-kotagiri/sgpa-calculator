import 'package:flutter/material.dart';

class NotificationsDisplayWidget extends StatefulWidget {
  @override
  _NotificationsDisplayWidgetState createState() =>
      _NotificationsDisplayWidgetState();
}

class _NotificationsDisplayWidgetState
    extends State<NotificationsDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(
            color: Colors.cyan,
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
