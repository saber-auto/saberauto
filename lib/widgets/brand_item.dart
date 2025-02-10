import 'package:flutter/material.dart';
import '../models/car_brand.dart';

class BrandItem extends StatelessWidget {
  final CarBrand brand;
  final VoidCallback onTap;

  const BrandItem({super.key, required this.brand, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(brand.logoUrl, width: 200, height: 200), // Brand logo
            const SizedBox(height: 8),
            Text(brand.name,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
