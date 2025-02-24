// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import '../models/car_brand.dart';
import '../widgets/brand_item.dart';
import '../screens/brand_details_screen.dart';
import '../screens/category_services_screen.dart'; // Import the CategoryServicesScreen

class ServicesScreen extends StatelessWidget {
  final List<CarBrand> carBrands = [
    CarBrand(id: '1', name: 'Toyota', logoUrl: '/images/toyota.png'),
    CarBrand(id: '2', name: 'Mercedes-Benz', logoUrl: '/images/mercedes.png'),
    CarBrand(id: '3', name: 'Ford', logoUrl: '/images/ford.png'),
    CarBrand(id: '4', name: 'BMW', logoUrl: '/images/bmw.png'),
    CarBrand(id: '5', name: 'Honda', logoUrl: '/images/honda.png'),
    CarBrand(id: '6', name: 'Audi', logoUrl: '/images/audi.png'),
    CarBrand(id: '7', name: 'Chevrolet', logoUrl: '/images/chevrolet.png'),
    CarBrand(id: '8', name: 'Nissan', logoUrl: '/images/nissan.png'),
    CarBrand(id: '9', name: 'Hyundai', logoUrl: '/images/hyundai.png'),
    CarBrand(id: '10', name: 'Volkswagen', logoUrl: '/images/volkswagen.png'),
  ];

  final int selectedIndex;
  final bool isUserLoggedIn;

  ServicesScreen(
      {super.key, required this.selectedIndex, required this.isUserLoggedIn});

  void _logout(BuildContext context) {
    // Implement logout functionality
    Navigator.of(context)
        .pushReplacementNamed('/login'); // Redirect to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marque de voitures')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Services Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Bouquets de fleurs'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryServicesScreen(category: 'bouquets'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Papillons'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryServicesScreen(category: 'papillons'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Stickers'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryServicesScreen(category: 'stickers'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Location des voitures'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryServicesScreen(
                        category: 'Location des voitures'),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('Sport Cars'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryServicesScreen(category: 'Sport Car'),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Deconnexion'),
              leading: Icon(Icons.exit_to_app, color: Colors.red),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1,
          ),
          itemCount: carBrands.length,
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BrandDetailsScreen(brand: carBrands[index]),
                  ),
                );
              },
              child: Card(
                color: Colors.blueGrey[100],
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      carBrands[index].logoUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8),
                    Text(
                      carBrands[index].name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
