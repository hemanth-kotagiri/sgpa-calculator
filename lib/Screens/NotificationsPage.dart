import 'package:flutter/material.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';
import 'package:sgpa_calc/Widgets/AllNotificationsWidget.dart';
import 'package:sgpa_calc/Widgets/LoadingWidget.dart';
import 'package:sgpa_calc/Widgets/NavBar.dart';

class NotificationsDisplayWidget extends StatefulWidget {
  @override
  _NotificationsDisplayWidgetState createState() =>
      _NotificationsDisplayWidgetState();
}

class _NotificationsDisplayWidgetState extends State<NotificationsDisplayWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          "JNTUH Latest Notifications",
          style: TextStyle(
            color: Colors.cyan,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ResultFetcher().fetchNotifications(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoadingWidget(
                animatedText: "Loading Latest Notifications...",
              );
            } else {
              return AllNotificationsList(givenData: snapshot.data);
            }
          }),
    );
  }
}
