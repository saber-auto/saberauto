import 'package:flutter/material.dart';
import '../models/car_brand.dart';
import 'part_details_screen.dart';

class BrandDetailsScreen extends StatefulWidget {
  final CarBrand brand;

  const BrandDetailsScreen({super.key, required this.brand});

  @override
  _BrandDetailsScreenState createState() => _BrandDetailsScreenState();
}

class _BrandDetailsScreenState extends State<BrandDetailsScreen> {
  String selectedCategory = 'Pièces moteur';

  final Map<String, List<String>> carParts = {
    'Pièces moteur': ['bougie allumage', 'filtre a huile', 'piston'],
    'Freins': ['Plaquette de frein', 'Disque de frein', 'Liquide de frein'],
    'Accessoires': ['Housse de voiture', 'Desodorisant', 'Housses de siege'],
    'Éclairage': ['Ampoule LED', 'Phare avant', 'Feu arriere'],
  };

  // URL de base pour Supabase
  final String supabaseBaseUrl =
      'https://uzlvrfhgagilsbzfkrjs.supabase.co/storage/v1/object/public/pieces/';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(widget.brand.name)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Pièces pour ${widget.brand.name}',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ...carParts.keys.map((category) {
              return ListTile(
                title: Text(category),
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                  Navigator.pop(context); // Ferme le menu
                },
              );
            }),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = screenWidth < 600
              ? 2
              : 4; // 2 colonnes sur mobile, 4 sur grands écrans

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    screenWidth * 0.05), // Ajuste selon la taille de l'écran
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Catégorie : $selectedCategory',
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: screenWidth * 0.03,
                      mainAxisSpacing: screenWidth * 0.03,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: carParts[selectedCategory]!.length,
                    itemBuilder: (ctx, index) {
                      String partName = carParts[selectedCategory]![index];

                      // URL complète de l'image
                      String imageUrl = '$supabaseBaseUrl$partName.png';

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
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    imageUrl,
                                    fit: BoxFit.contain,
                                    width: screenWidth * 0.3,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.image_not_supported,
                                          size: screenWidth * 0.1);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                partName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
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
          );
        },
      ),
    );
  }
}
