import 'package:flutter/material.dart';
import '../models/service.dart';
import '../widgets/service_item.dart';
import 'service_details_screen.dart';

class CategoryServicesScreen extends StatelessWidget {
  final String category;

  CategoryServicesScreen({super.key, required this.category});

  final Map<String, List<Service>> categoryServices = {
    "Wedding Car": [
      Service(
          id: '4',
          title: 'Elegant Wedding Car',
          description:
              'Beautifully decorated wedding car for your special day.',
          price: 99.99,
          imageUrl: 'assets/images/saber.png'), // Image set to saber.png
    ],
    "Luxury Car": [
      Service(
          id: '5',
          title: 'VIP Car Styling',
          description: 'Luxury car decoration with premium materials.',
          price: 149.99,
          imageUrl: 'assets/images/saber.png'), // Image set to saber.png
    ],
    "Classic Car": [
      Service(
          id: '6',
          title: 'Retro Classic Styling',
          description: 'Classic car decoration for a vintage look.',
          price: 89.99,
          imageUrl: 'assets/images/saber.png'), // Image set to saber.png
    ],
    "Modern Car": [
      // Added more services
      Service(
          id: '7',
          title: 'Modern Car Styling',
          description: 'Sleek and modern design for a futuristic car look.',
          price: 129.99,
          imageUrl: 'assets/images/saber.png'), // Image set to saber.png
    ],
    "Sport Car": [
      // Added more services
      Service(
          id: '8',
          title: 'Sporty Car Look',
          description: 'Aggressive styling for sport cars.',
          price: 159.99,
          imageUrl: 'assets/images/saber.png'), // Image set to saber.png
    ],
  };

  @override
  Widget build(BuildContext context) {
    final List<Service> services = categoryServices[category] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio:
                0.75, // Aspect ratio to make the items smaller and compact
          ),
          itemCount: services.length,
          itemBuilder: (ctx, index) {
            return ServiceItem(
              service: services[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsScreen(
                      service: services[index],
                      serviceId: services,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
