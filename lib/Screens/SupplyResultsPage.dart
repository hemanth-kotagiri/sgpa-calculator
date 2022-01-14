import 'package:flutter/material.dart';
import 'package:sgpa_calc/Widgets/AllResultsWidget.dart';
import 'package:sgpa_calc/Widgets/LoadingWidget.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';
import 'package:sgpa_calc/Widgets/NavBar.dart';

class SupplyResultsDisplayWidget extends StatefulWidget {
  SupplyResultsDisplayWidget({Key key}) : super(key: key);

  @override
  _SupplyResultsDisplayWidget createState() => _SupplyResultsDisplayWidget();
}

class _SupplyResultsDisplayWidget extends State<SupplyResultsDisplayWidget>
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
              return LoadingWidget(
                animatedText: "Loading Supplementary Results...",
              );
            } else {
              return AllResultsList(
                data: snapshot.data,
                titleText: "Supplementary Results",
              );
            }
          }),
    );
  }
}
