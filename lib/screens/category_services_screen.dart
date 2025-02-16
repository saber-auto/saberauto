import 'package:flutter/material.dart';
import '../models/service.dart';
import '../widgets/service_item.dart';
import 'service_details_screen.dart';

// Supabase base URL for accessing your images
final String supabaseBaseUrl =
    'https://uzlvrfhgagilsbzfkrjs.supabase.co/storage/v1/object/public/';

class CategoryServicesScreen extends StatelessWidget {
  final String category;

  const CategoryServicesScreen({super.key, required this.category});

  // Function to fetch services for each category
  Map<String, List<Service>> get categoryServices {
    return {
      "bouquets": [
        Service(
          id: 'bouquet_1',
          title: 'Roses Élégantes',
          description:
              'Un magnifique bouquet de roses rouges pour toutes occasions.',
          prixLocation: 99.99,
          prixAchat: 199.99,
          images: [
            '$supabaseBaseUrl/bouquets/wedding_car_2.png',
            '$supabaseBaseUrl/bouquets/wedding_car_3.png',
          ],
        ),
        Service(
          id: 'bouquet_2',
          title: 'Bouquet de Fleurs Sauvages',
          description:
              'Un bouquet élégant avec des fleurs sauvages pour un look naturel.',
          prixLocation: 109.99,
          prixAchat: 219.99,
          images: [
            '$supabaseBaseUrl/bouquets/wedding_car_1.png',
          ],
        ),
      ],
      "papillons": [
        Service(
          id: 'papillons_1',
          title: 'Papillon Royal',
          description:
              'Un design majestueux représentant la transformation et l’élégance.',
          prixLocation: 149.99,
          prixAchat: 299.99,
          images: [
            '$supabaseBaseUrl/papillons/papillon_royal.png',
            '$supabaseBaseUrl/papillons/papillon_royal_detail.png',
          ],
        ),
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final List<Service> services = categoryServices[category] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: services.length,
              itemBuilder: (ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
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
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
