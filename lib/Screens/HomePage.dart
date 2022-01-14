import 'package:flutter/material.dart';
import 'package:sgpa_calc/Screens/NotificationsPage.dart';
import 'package:sgpa_calc/Screens/RegularResultsPage.dart';
import 'package:sgpa_calc/Screens/SupplyResultsPage.dart';
import 'package:sgpa_calc/Screens/ResultsFetcherOldPage.dart';

class Home extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    List<Widget> _pages = [
      NotificationsDisplayWidget(),
      SupplyResultsDisplayWidget(),
      RegularResultsDisplayWidget(),
      ResultsFetcherWidget()
    ];

    void _onPageChanged(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    void _bottomItemTapped(int selectedIdx) {
      _pageController.jumpToPage(selectedIdx);
    }

    return Scaffold(
      //body: _pages.elementAt(_selectedIndex),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _bottomItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            tooltip: "Latest Notifications from JNTUH",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'All Supply Results',
            tooltip: "Results Links for All Supplementary Exams",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
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
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
