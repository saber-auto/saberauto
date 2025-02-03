import 'package:flutter/material.dart';
import '../widgets/service_item.dart';
import '../models/service.dart';
import '../widgets/common_ui_wrapper.dart'; // Import the common UI wrapper

class ServicesScreen extends StatelessWidget {
  final List<Service> services = [
    Service(
        id: '1',
        title: 'Oil Change',
        description: 'Standard oil change',
        price: 29.99),
    Service(
        id: '2',
        title: 'Tire Rotation',
        description: 'Rotate all four tires',
        price: 19.99),
    Service(
        id: '3',
        title: 'Brake Inspection',
        description: 'Inspect and adjust brakes',
        price: 49.99),
  ];

  final int selectedIndex; // This will hold the background index for the screen

  ServicesScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return CommonUIWrapper(
      selectedIndex:
          selectedIndex, // Pass the selected index for the background
      child: Column(
        children: [
          AppBar(
            title: const Text('Services'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: services.length,
              itemBuilder: (ctx, index) =>
                  ServiceItem(service: services[index]),
            ),
          ),
        ],
      ),
    );
  }
}
