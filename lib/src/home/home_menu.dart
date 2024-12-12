import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Background with Title and Logo
          Stack(
            children: [
              // Background Image
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Dark overlay for better contrast
              Container(
                height: 200,
                color: Colors.black.withOpacity(0.4),
              ),
              // Title and Logo
              Positioned(
                bottom: 28,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Restaurant Name and Subtitle
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'El Cabanyal',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            height: 36 / 32,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'FASTFOOD · BURGERS',
                          style: TextStyle(
                            fontFamily: 'Urbanist',
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 14 / 14,
                          ),
                        ),
                      ],
                    ),
                    // Logo
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: Text(
                        '小红书',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Icon Tabs
          Align(
            alignment: Alignment.topCenter, // Position it at the top center
            child: Transform.translate(
              offset: const Offset(
                  0, -20.0), // Move the widget upwards by 20 pixels
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 6.0, horizontal: 12.0), // Smaller padding
                width:
                    MediaQuery.of(context).size.width * 0.6, // Reduce the width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(50), // Smaller rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconTab(
                        assetPath: 'assets/images/delivery_scooter.png',
                        isSelected: false),
                    IconTab(
                        assetPath: 'assets/images/bag.png', isSelected: true),
                    IconTab(
                        assetPath: 'assets/images/seated_person.png',
                        isSelected: false),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconTab extends StatelessWidget {
  final String assetPath;
  final bool isSelected;

  const IconTab({super.key, required this.assetPath, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: isSelected ? 2 : 1,
        ),
      ),
      padding: const EdgeInsets.all(8.0), // Add padding for better alignment
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String? promotion;

  MenuItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.promotion,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      title: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      promotion: json['promotion'],
    );
  }
}
