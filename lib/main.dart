import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/services_screen.dart';
import 'screens/login_screen.dart'; // Import LoginScreen
import 'screens/register_screen.dart'; // Import RegisterScreen
import 'providers/cart_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://uzlvrfhgagilsbzfkrjs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InV6bHZyZmhnYWdpbHNiemZrcmpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzgyNjEwMTAsImV4cCI6MjA1MzgzNzAxMH0.bPzLVW-ODm8J9-75ttL5bCODkVQ5kGmbeBATXco2ag8',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
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
      // Define routes
      initialRoute: '/', // Set the initial route to SplashScreen
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(), // Register route
        '/services': (context) => ServicesScreen(
            selectedIndex: 1, isUserLoggedIn: true), // ServicesScreen route
      },
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

  // Navigate to Login Screen or Services Screen based on authentication status
  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3)); // Splash for 3 seconds
    final user = Supabase.instance.client.auth.currentUser;

    // If user is logged in, navigate to ServicesScreen; otherwise, go to LoginScreen
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/services');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/saber.png'), // Splash logo
      ),
    );
  }
}
