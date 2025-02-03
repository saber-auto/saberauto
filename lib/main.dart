import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart'; // Corrected import for the LoginScreen
import 'dart:async';

void main() async {
  // Initialize Supabase with your URL and anonKey
  await Supabase.initialize(
    url: 'https://uzlvrfhgagilsbzfkrjs.supabase.co', // Your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV6bHZyZmhnYWdpbHNiemZrcmpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyNjEwMTAsImV4cCI6MjA1MzgzNzAxMH0.bPzLVW-ODm8J9-75ttL5bCODkVQ5kGmbeBATXco2ag8', // Your Supabase anon key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Shop App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  // Function to handle navigation based on auth state
  _navigateToNextScreen() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Show splash for 3 seconds
    final user = Supabase.instance.client.auth.currentUser;

    if (user != null) {
      // If the user is already logged in, navigate to the HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const HomeScreen(
                  selectedIndex: 1,
                )),
      );
    } else {
      // Otherwise, navigate to the LoginScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child:
            Image.asset('assets/images/saber.png'), // Display logo from assets
      ),
    );
  }
}
