import 'package:flutter/material.dart';

class AllNotificationsList extends StatelessWidget {
  final givenData;
  const AllNotificationsList({Key key, @required this.givenData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: givenData.length,
            itemBuilder: (context, index) {
              final data = givenData[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Column(
                        children: [
                          _getDate(data),
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

  Center _getDate(data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          data["notification_date"], // Date
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
      examName = data["notification_description"].split("PUBLISHED.")[0] +
          "PUBLISHED.";
      lastDate = data["notification_description"].split("PUBLISHED.")[1];
    } catch (Exception) {
      print(Exception);
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
          ),
        )
      ],
    );
  }
}
