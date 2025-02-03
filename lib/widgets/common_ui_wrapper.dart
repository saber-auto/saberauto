import 'package:flutter/material.dart';
import '../data/bg_data.dart'; // Import your bg_data.dart file

class CommonUIWrapper extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  // Constructor to accept the child widget (screen content) and the selected background index
  const CommonUIWrapper(
      {super.key, required this.child, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/${bgList[selectedIndex]}'), // Use bgList from bg_data.dart
            fit: BoxFit.fill,
          ),
        ),
        child: child, // This is where the content of each screen will be placed
      ),
    );
  }
}
