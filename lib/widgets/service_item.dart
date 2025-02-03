import 'package:flutter/material.dart';
import '../models/service.dart';

class ServiceItem extends StatelessWidget {
  final Service service;

  // ignore: prefer_const_constructors_in_immutables
  ServiceItem({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(service.title),
        subtitle: Text(service.description),
        trailing: Text('\$${service.price.toStringAsFixed(2)}'),
      ),
    );
  }
}
