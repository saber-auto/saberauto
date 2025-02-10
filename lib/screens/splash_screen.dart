// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'services_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  late AnimationController _driveController;
  late Animation<Offset> _driveAnimation;
  late AnimationController _smokeController;
  late Animation<Offset> _smokeAnimation;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    // Shake animation (engine starting)
    _shakeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _shakeAnimation = Tween<double>(begin: -5, end: 5).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));

    // Drive away animation
    _driveController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _driveAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(3.0, -1.5), // Moves right and slightly up
    ).animate(CurvedAnimation(parent: _driveController, curve: Curves.easeIn));

    // Smoke animation (appears and moves up)
    _smokeController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _smokeAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, -1), // Moves smoke up
    ).animate(CurvedAnimation(parent: _smokeController, curve: Curves.easeOut));

    _playSoundAndAnimate();
  }

  void _playSoundAndAnimate() async {
    await _audioPlayer.play(AssetSource('sounds/car_drive.mp3'));

    // Start shake effect
    _shakeController.repeat(reverse: true);

    Timer(Duration(milliseconds: 800), () {
      _shakeController.stop();

      // Start drive animation
      _driveController.forward().then((_) {
        _smokeController.forward(); // Trigger smoke animation

        // Navigate to Service Screen after animation completes
        Timer(Duration(seconds: 1), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => ServicesScreen(
                        selectedIndex: 2,
                        isUserLoggedIn: false,
                      )));
        });
      });
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _driveController.dispose();
    _smokeController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Smoke effect
            SlideTransition(
              position: _smokeAnimation,
              child: FadeTransition(
                opacity: _smokeController,
                child: Image.asset('assets/images/smoke.png',
                    width: 150, height: 100),
              ),
            ),

            // Car logo with animations
            AnimatedBuilder(
              animation: Listenable.merge([_shakeController, _driveController]),
              builder: (context, child) {
                return Transform.translate(
                  offset:
                      Offset(_shakeAnimation.value, 0) + _driveAnimation.value,
                  child: child,
                );
              },
              child: Image.asset('assets/images/saber.png',
                  width: 200, height: 200),
            ),
          ],
        ),
      ),
    );
  }
}
