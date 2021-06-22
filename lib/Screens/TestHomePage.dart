import 'package:flutter/material.dart';
import 'package:sgpa_calc/Widgets/courses.dart';
import 'package:sgpa_calc/Widgets/ResultsFetcherWidget.dart';

class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  int _selectedIndex = 0;
  static List<Widget> _pages = [CoursesWidget(), ResultsFetcherWidget()];

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
            icon: Icon(Icons.calculate),
            label: '3,1 Calculator',
            tooltip: "Calculator for 3,1 subjects",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Results Fetcher',
            tooltip: "Fetch Results of previous semesters",
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
