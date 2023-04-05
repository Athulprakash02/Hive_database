import 'package:flutter/material.dart';
import 'package:hive_db_sample/db/functions/db_functions.dart';
import 'package:hive_db_sample/screen/screen_add.dart';
import 'package:hive_db_sample/screen/screen_details.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _currentIndex = 0;

  final pages = [
    ScreenDetails(),
    ScreenAdd(),
  ];

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_outlined), label: 'Details'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          ]),
      body: pages[_currentIndex],
    );
  }
}
