import 'package:flutter/material.dart';
import '../models/service.dart';
import '../widgets/service_item.dart';
import '../screens/login_screen.dart';
import '../screens/service_details_screen.dart'; // Ensure this screen exists
import '../screens/category_services_screen.dart'; // Create this for categories

class ServicesScreen extends StatelessWidget {
  final List<Service> services = [
    Service(
        id: '1',
        title: 'Oil Change',
        description: 'Standard oil change',
        price: 29.99,
        imageUrl: 'assets/images/oil_change.jpg'),
    Service(
        id: '2',
        title: 'Tire Rotation',
        description: 'Rotate all four tires',
        price: 19.99,
        imageUrl: 'assets/images/tire_rotation.jpg'),
    Service(
        id: '3',
        title: 'Brake Inspection',
        description: 'Inspect and adjust brakes',
        price: 49.99,
        imageUrl: 'assets/images/brake_inspection.jpg'),
  ];

  final int selectedIndex;
  final bool isUserLoggedIn;

  ServicesScreen(
      {super.key, required this.selectedIndex, required this.isUserLoggedIn});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Services')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Car Decoration Services',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Wedding Car Decoration'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryServicesScreen(category: 'Wedding Car'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Luxury Car Decoration'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryServicesScreen(category: 'Luxury Car'),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Classic Car Decoration'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryServicesScreen(category: 'Classic Car'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1, // Makes it square
          ),
          itemCount: services.length,
          itemBuilder: (ctx, index) {
            return ServiceItem(
              service: services[index],
              onTap: () {
                if (isUserLoggedIn) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceDetailsScreen(
                        service: services[index],
                        serviceId: Service,
                      ),
                    ),
                  );
                } else {
                  _showLoginPrompt(context);
                }
              },
            );
          },
        ),
      ),
    );
  }

  // Show login or register prompt
  void _showLoginPrompt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Required'),
        content: const Text(
            'Please log in or create an account to access this service.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Log In'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const LoginScreen()), // Replace with register screen if needed
              );
            },
            child: const Text('Create Account'),
          ),
        ],
      ),
    );
  }
}
