import 'package:flutter/material.dart';

import 'NewResultsFetcherWidget.dart';

class AllResultsList extends StatefulWidget {
  final data, titleText;
  final isSearching;
  const AllResultsList({
    Key key,
    @required this.data,
    @required this.titleText,
    @required this.isSearching,
  }) : super(key: key);

  @override
  _AllResultsListState createState() => _AllResultsListState();
}

class _AllResultsListState extends State<AllResultsList> {
  List links = [];
  List filteredLinks = [];
  TextEditingController _filterController = TextEditingController();

  @override
  void initState() {
    links = widget.data;
    filteredLinks = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.isSearching
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _filterController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _filterController.text = "";
                        setState(
                          () {
                            filteredLinks = links;
                          },
                        );
                      },
                    ),
                    hintText: "Search Here",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _filterLinks(value);
                  },
                ),
              )
            : SizedBox.shrink(),
        Expanded(
          child: ListView.builder(
            itemCount: filteredLinks.length,
            itemBuilder: (context, index) {
              final data = filteredLinks[index];
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

  void _filterLinks(value) {
    setState(() {
      filteredLinks = links
          .where((link) =>
              link["exam_name"].toLowerCase().contains(value.toLowerCase()))
          .toList();

      filteredLinks += links
          .where((link) =>
              link["release_date"].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
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
