// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/service.dart';
import 'login_screen.dart';
import 'booking_page.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final Service service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  int _selectedIndex = 0; // Index to keep track of the selected image
  late PageController _pageController; // Controller for page view
  final double _thumbnailSize = 100; // Thumbnail size
  double _scale = 1.0; // Scale factor for hover effect

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text(widget.service.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gallery of images with swipe feature and navigation arrows
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: widget.service.images.length,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index; // Update the selected index
                      });
                    },
                    itemBuilder: (context, index) {
                      return Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 250, // Square width
                            height: 250, // Square height
                            child: Image.network(
                              widget.service.images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    left: 10,
                    top: 110,
                    child: IconButton(
                      onPressed: () {
                        if (_selectedIndex > 0) {
                          _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_left,
                        color: Colors.white.withOpacity(0.7),
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 110,
                    child: IconButton(
                      onPressed: () {
                        if (_selectedIndex < widget.service.images.length - 1) {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white.withOpacity(0.7),
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Thumbnails for quick selection with hover effect and centered layout
            Center(
              child: SizedBox(
                height: _thumbnailSize + 20, // Height for better view
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.service.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex =
                              index; // Select image from thumbnails
                        });
                        _pageController
                            .jumpToPage(index); // Jump to selected image
                      },
                      onPanUpdate: (details) {
                        setState(() {
                          _scale = 1.1; // Scale up on hover
                        });
                      },
                      onPanEnd: (details) {
                        setState(() {
                          _scale = 1.0; // Reset scale when hover ends
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding:
                            const EdgeInsets.all(5), // White background padding
                        decoration: BoxDecoration(
                          color: Colors
                              .white, // White background for the thumbnail container
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _selectedIndex == index
                                ? Colors
                                    .black // Black border for selected thumbnail
                                : Colors
                                    .transparent, // No border for non-selected thumbnails
                            width: 3, // Border thickness
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: _thumbnailSize,
                            height: _thumbnailSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AnimatedScale(
                              duration: Duration(milliseconds: 200),
                              scale: _scale, // Scale effect on hover
                              child: Image.network(
                                widget.service.images[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Description of the service
            Text(
              widget.service.description,
              style: const TextStyle(
                  fontSize: 16, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            const SizedBox(height: 10),
            // Prices display
            Text(
              'Prix de location: TND ${widget.service.prixLocation.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text(
              'Prix d\'achat: TND ${widget.service.prixAchat.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 20),
            // "Allouer" and "Acheter" buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _handleBooking(context, user, widget.service.id, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: const Text('Allouer'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _handleBooking(context, user, widget.service.id, false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    textStyle: TextStyle(fontSize: 16),
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

  // Function to handle authentication and navigation
  void _handleBooking(
      BuildContext context, User? user, String serviceId, bool isRenting) {
    if (user == null) {
      // Redirect to login screen if user is not logged in
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      ).then((_) {
        // After login, check if the user is logged in
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
      // Directly navigate to booking screen if user is logged in
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
