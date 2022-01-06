import 'package:flutter/material.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';

import 'NavBar.dart';
import 'NewResultsFetcherWidget.dart';

class SupplyResultsDisplayWidget extends StatefulWidget {
  SupplyResultsDisplayWidget({Key key}) : super(key: key);

  @override
  _SupplyResultsDisplayWidget createState() => _SupplyResultsDisplayWidget();
}

class _SupplyResultsDisplayWidget extends State<SupplyResultsDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text("Supplimentary Exams"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ResultFetcher().fetchAllSupplyResultsLinks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  backgroundColor: Colors.black,
                ),
              );
            } else {
              print(snapshot.data.length);
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final data = snapshot.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            data.values.elementAt(1), // Date
                          ),
                        ),
                        ListTile(
                          title: Text(
                            data.values.elementAt(0), // Exam Name
                          ),
                          onTap: () => {_individualResultPage(data)},
                        ),
                        Divider(thickness: 2),
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }

  _individualResultPage(Map<String, dynamic> data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Supplimentary Results",
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
