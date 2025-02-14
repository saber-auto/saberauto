import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/service.dart';
import 'login_screen.dart';
import 'booking_page.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final Service service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final user =
        supabase.auth.currentUser; // Vérifier si l'utilisateur est connecté

    return Scaffold(
      appBar: AppBar(title: Text(service.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage des images sous forme de carousel
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: service.images.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      service.images[index],
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Titre du service
            Text(
              service.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Description du service
            Text(
              service.description,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            const SizedBox(height: 10),
            // Affichage des prix
            Text(
              'Prix de location: TND ${service.prixLocation.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            ),
            Text(
              'Prix d\'achat: TND ${service.prixAchat.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 20),
            // Boutons "Allouer" et "Acheter"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _handleBooking(context, user, service.id, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Allouer'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _handleBooking(context, user, service.id, false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Acheter'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour gérer l'authentification et la navigation
  void _handleBooking(
      BuildContext context, User? user, String serviceId, bool isRenting) {
    if (user == null) {
      // Redirection vers l'écran de connexion si l'utilisateur n'est pas connecté
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      ).then((_) {
        // Après connexion, vérifier si l'utilisateur est connecté
        if (Supabase.instance.client.auth.currentUser != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BookingScreen(serviceId: serviceId, isRenting: isRenting),
            ),
          );
        }
      });
    } else {
      // Aller directement à l'écran de réservation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BookingScreen(serviceId: serviceId, isRenting: isRenting),
        ),
      );
    }
  }
}
