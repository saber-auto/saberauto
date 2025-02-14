// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../models/service.dart';
import '../widgets/service_item.dart';
import 'service_details_screen.dart';

class CategoryServicesScreen extends StatelessWidget {
  final String category;

  CategoryServicesScreen({super.key, required this.category});

  final Map<String, List<Service>> categoryServices = {
    "bouquet": List.generate(
        10,
        (index) => Service(
              id: 'w$index',
              title: 'bouquet de fleur',
              description: 'Elegant wedding car service option.',
              prixLocation: 99.99 + index * 5,
              prixAchat: 199.99 + index * 10,
              images: [
                './images/wedding_car_$index.jpg',
                './images/wedding_car_$index.jpg'
              ],
            )),
    "papillons": List.generate(
        9,
        (index) => Service(
              id: 'l$index',
              title: 'papillons',
              description: 'Exclusive luxury car decoration.',
              prixLocation: 149.99 + index * 10,
              prixAchat: 299.99 + index * 15,
              images: [
                'assets/images/luxury_car_$index.png',
                'assets/images/luxury_car_$index.png'
              ],
            )),
    "stickers": List.generate(
        10,
        (index) => Service(
              id: 'c$index',
              title: 'stickers',
              description: 'Timeless classic car styling.',
              prixLocation: 89.99 + index * 4,
              prixAchat: 179.99 + index * 8,
              images: [
                'assets/images/classic_car_${index}_1.png',
                'assets/images/classic_car_${index}_2.png'
              ],
            )),
    "Location des voitures": List.generate(
        10,
        (index) => Service(
              id: 'm$index',
              title: 'location des voitures de lux',
              description:
                  'Sleek modern design for a futuristic touch #$index.',
              prixLocation: 129.99 + index * 6,
              prixAchat: 259.99 + index * 12,
              images: [
                'assets/images/modern_car_$index.png',
                'assets/images/modern_car_$index.png'
              ],
            )),
    "Sport Car": List.generate(
        10,
        (index) => Service(
              id: 's$index',
              title: 'Sporty Car Design #$index',
              description: 'Dynamic and aggressive sporty look #$index.',
              prixLocation: 159.99 + index * 7,
              prixAchat: 319.99 + index * 18,
              images: [
                'assets/images/sport_car_${index}_1.png',
                'assets/images/sport_car_${index}_2.png'
              ],
            )),
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
            crossAxisCount: 3, // Adjusted for mobile responsiveness
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemCount: services.length,
          itemBuilder: (ctx, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: ServiceItem(
                service: services[index],
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ServiceDetailsScreen(service: services[index]),
                    ),
                  );
                },
                onRent: () {
                  print("Renting: ${services[index].title}");
                },
                onBuy: () {
                  print("Buying: ${services[index].title}");
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
