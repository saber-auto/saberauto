import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/service.dart';

class ServiceItem extends StatelessWidget {
  final Service service;
  final VoidCallback onTap;
  final VoidCallback onRent;
  final VoidCallback onBuy;

  const ServiceItem({
    super.key,
    required this.service,
    required this.onTap,
    required this.onRent,
    required this.onBuy,
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
            child: Image.asset(service.images[0],
                height: 300, width: 300, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              service.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onRent,
                child: Text("Rent (${formatPrice(service.prixLocation)})"),
              ),
              ElevatedButton(
                onPressed: onBuy,
                child: Text("Buy (${formatPrice(service.prixAchat)})"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
