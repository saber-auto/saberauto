import 'package:flutter/material.dart';
import '../models/service.dart';

class ServiceItem extends StatelessWidget {
  final Service service;
  final Function() onTap;

  const ServiceItem({super.key, required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image container with better size control
            Container(
              width: 100, // Reduced image width
              height: 100, // Reduced image height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(service.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Service title with small font size
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                service.title,
                style: const TextStyle(
                  fontSize: 12, // Smaller font size
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            // Service description with small font size
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                service.description,
                style: const TextStyle(
                  fontSize: 10, // Smaller font size for description
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
                maxLines: 2, // Limit description lines
                overflow: TextOverflow.ellipsis, // Truncate if too long
              ),
            ),
            const SizedBox(height: 4),
            // Service price with green text
            Text(
              '\$${service.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 12, // Smaller font size for price
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
