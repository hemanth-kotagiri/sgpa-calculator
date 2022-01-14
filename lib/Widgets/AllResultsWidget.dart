import 'package:flutter/material.dart';

import 'NewResultsFetcherWidget.dart';

class AllResultsList extends StatefulWidget {
  final data, titleText;
  const AllResultsList({Key key, @required this.data, @required this.titleText})
      : super(key: key);

  @override
  _AllResultsListState createState() => _AllResultsListState();
}

class _AllResultsListState extends State<AllResultsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (context, index) {
              final data = widget.data[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => {_individualResultPage(data)},
                      child: resultCard(data),
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

  Center getDate(data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          data.values.elementAt(1), // Date
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  ListTile getSupplyExamName(data) {
    return ListTile(
      title: Text(data.values.elementAt(0), // Exam Name
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue[200],
          )),
    );
  }

  Card resultCard(data) {
    return Card(
      child: Column(
        children: [
          getDate(data),
          getSupplyExamName(data),
        ],
      ),
    );
  }

  _individualResultPage(Map<String, dynamic> data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.titleText,
                style: TextStyle(color: Colors.cyan),
              ),
              centerTitle: true,
            ),
            body: NewResultsFetcherWidget(data: data),
          );
        },
      ),
    );
  }
}
