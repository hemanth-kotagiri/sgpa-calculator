import 'package:flutter/material.dart';
import 'package:sgpa_calc/Widgets/RegularResultsDisplayWidget.dart';
import 'package:sgpa_calc/Widgets/SupplyResultsDisplayWidget.dart';
import 'package:sgpa_calc/Widgets/ResultsFetcherWidget.dart';

class Home extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> _pages = [
    SupplyResultsDisplayWidget(),
    RegularResultsDisplayWidget(),
    ResultsFetcherWidget()
  ];

  void _changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'All Supply Results',
            tooltip: "Results Links for All Supplementary Exams",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bolt),
            label: 'All Regular Results',
            tooltip: "Results Links for All Regular Exams",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'R18 Regular Results Fetcher',
            tooltip: "Fetch Regular Results of R18 Batch Students",
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.grey[600],
        onTap: _changeScreen,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
