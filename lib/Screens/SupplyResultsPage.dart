import 'package:flutter/material.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:sgpa_calc/Widgets/NavBar.dart';

import 'package:sgpa_calc/Widgets/NewResultsFetcherWidget.dart';

class SupplyResultsDisplayWidget extends StatefulWidget {
  SupplyResultsDisplayWidget({Key key}) : super(key: key);

  @override
  _SupplyResultsDisplayWidget createState() => _SupplyResultsDisplayWidget();
}

class _SupplyResultsDisplayWidget extends State<SupplyResultsDisplayWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: Text(
          "Supplementary Exams",
          style: TextStyle(
            color: Colors.cyan,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ResultFetcher().fetchAllSupplyResultsLinks(),
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
                            WavyAnimatedText(
                                'Loading Supplementary Results...'),
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
                              child: GestureDetector(
                                onTap: () => {_individualResultPage(data)},
                                child: Card(
                                  child: Column(
                                    children: [
                                      Center(
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
                                      ),
                                      ListTile(
                                        title: Text(
                                            data.values
                                                .elementAt(0), // Exam Name
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.blue[200],
                                            )),
                                      ),
                                    ],
                                  ),
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

  _individualResultPage(Map<String, dynamic> data) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Supplementary Results",
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

  @override
  bool get wantKeepAlive => true;
}
