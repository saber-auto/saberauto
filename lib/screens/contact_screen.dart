import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Auto Shop',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('123 Main St', style: TextStyle(fontSize: 18)),
            Text('City, State, ZIP', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Phone: (123) 456-7890', style: TextStyle(fontSize: 18)),
            Text('Email: info@autoshop.com', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
