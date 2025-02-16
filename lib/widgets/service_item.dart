import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/service.dart';

class ServiceItem extends StatelessWidget {
  final Service service;
  final VoidCallback onTap;

  const ServiceItem({
    super.key,
    required this.service,
    required this.onTap,
  });

  String formatPrice(double price) {
    final format = NumberFormat.simpleCurrency(locale: 'fr_TN', name: 'TND');
    return format.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap, // Navigate to details on tap
            child: Center(
              child: Image.network(
                service.images[0], // The first image for the service
                height: 80, // Adjust the height to make the image smaller
                width: 80, // Adjust the width to match the height
                fit: BoxFit
                    .cover, // Maintain the aspect ratio while covering the area
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              service.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              service.description,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatPrice(service.prixLocation),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
