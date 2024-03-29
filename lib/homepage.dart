import 'package:flutter/material.dart';
import 'package:covidupdate/stats.dart';
import 'package:covidupdate/health.dart';
import 'package:covidupdate/news.dart';
import 'package:covidupdate/help.dart';

class HomePage extends StatefulWidget {
  static const routeName='/Home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Stats(),
    Health(),
    News(),
    Help(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.announcement,
              color: Color(0xFF7777FF),
            ),
            title: Text('Stats'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.healing,
              color: Color(0xFF7777FF),
            ),
            title: Text('Health'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_releases,
              color: Color(0xFF7777FF),
            ),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.help,
              color: Color(0xFF7777FF),
            ),
            title: Text('Help'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF7777FF),
        onTap: _onItemTapped,
      ),
    );
  }
}
