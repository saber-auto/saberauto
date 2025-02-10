import 'package:flutter/material.dart';
import '../models/car_brand.dart';
import 'part_details_screen.dart'; // Ensure this screen exists

class BrandDetailsScreen extends StatefulWidget {
  final CarBrand brand;

  const BrandDetailsScreen({super.key, required this.brand});

  @override
  _BrandDetailsScreenState createState() => _BrandDetailsScreenState();
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  String selectedCategory = 'Engine Parts'; // Default category

  // Example categories and parts
  final Map<String, List<String>> carParts = {
    'Engine Parts': ['Spark Plug', 'Oil Filter', 'Piston'],
    'Brakes': ['Brake Pad', 'Disc Brake', 'Brake Fluid'],
    'Tires': ['Winter Tires', 'All-Season Tires', 'Performance Tires'],
    'Accessories': ['Car Cover', 'Air Freshener', 'Seat Covers'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.brand.name)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                '${widget.brand.name} Parts',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ...carParts.keys.map((category) {
              return ListTile(
                title: Text(category),
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                  Navigator.pop(context); // Close the drawer
                },
              );
              // ignore: unnecessary_to_list_in_spreads
            }).toList(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category: $selectedCategory',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1,
                ),
                itemCount: carParts[selectedCategory]!.length,
                itemBuilder: (ctx, index) {
                  String partName = carParts[selectedCategory]![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PartDetailsScreen(partName: partName),
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
                            'assets/images/saber.png', // Fixed image for all parts
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 8),
                          Text(
                            partName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
