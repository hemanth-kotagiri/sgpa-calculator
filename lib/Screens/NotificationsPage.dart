import 'package:flutter/material.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class NotificationsDisplayWidget extends StatefulWidget {
  @override
  _NotificationsDisplayWidgetState createState() =>
      _NotificationsDisplayWidgetState();
}

class _NotificationsDisplayWidgetState extends State<NotificationsDisplayWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      strokeWidth: 2,
                      backgroundColor: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Loading Notifications...'),
                          ],
                          isRepeatingAnimation: true,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        final data = snapshot.data[index];
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  children: [
                                    getDate(data),
                                    _getExamNameAndLastDate(data),
                                  ],
                                ),
                              ),
                            ),
                            Divider(thickness: 1, endIndent: 50, indent: 50),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

  Center getDate(data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          data.values.elementAt(0), // Date
          style: TextStyle(
            color: Colors.green[400],
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _getExamNameAndLastDate(data) {
    var examName;
    var lastDate;
    try {
      examName = data.values.elementAt(1).split("PUBLISHED.")[0] + "PUBLISHED.";
      lastDate = data.values.elementAt(1).split("PUBLISHED.")[1];
    } catch (Exception) {
      examName = data.values.elementAt(1);
      return ListTile(
        title: Text(
          examName,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
      );
    }
    return Column(
      children: [
        ListTile(
          title: Text(
            examName,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.amber,
            ),
          ),
        ),
        ListTile(
            title: Text(
          lastDate,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.red,
          ),
        ))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
