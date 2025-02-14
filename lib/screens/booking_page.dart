import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  final String serviceId;
  final bool isRenting;

  // Constructor to accept serviceId and isRenting
  const BookingScreen({
    super.key,
    required this.serviceId,
    required this.isRenting,
  });

  @override
  Widget build(BuildContext context) {
    // Add your screen implementation here
    return Scaffold(
      appBar: AppBar(title: Text('Booking Details')),
      body: Center(
        child: Text(
          'Booking for Service ID: $serviceId\nRenting: $isRenting',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
