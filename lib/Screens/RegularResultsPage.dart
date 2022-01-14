import 'package:flutter/material.dart';
import 'package:sgpa_calc/Services/FetchResult.dart';
import 'package:sgpa_calc/Widgets/AllResultsWidget.dart';
import 'package:sgpa_calc/Widgets/LoadingWidget.dart';
import 'package:sgpa_calc/Widgets/NavBar.dart';

class RegularResultsDisplayWidget extends StatefulWidget {
  RegularResultsDisplayWidget({Key key}) : super(key: key);

  @override
  _RegularResultsDisplayWidget createState() => _RegularResultsDisplayWidget();
}

class _RegularResultsDisplayWidget extends State<RegularResultsDisplayWidget>
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
          "Regular Exams",
          style: TextStyle(
            color: Colors.cyan,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ResultFetcher().fetchAllRegularResultsLinks(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return LoadingWidget(
                animatedText: "Loading Regular Results...",
              );
            } else {
              return AllResultsList(data: snapshot.data);
            }
          }),
    );
  }
}
