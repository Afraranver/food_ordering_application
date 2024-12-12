import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/util/appdata.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: const Offset(0, -20.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 12.0),
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
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
                        isSelected: false,
                      ),
                      IconTab(
                        assetPath: 'assets/images/bag.png',
                        isSelected: true,
                      ),
                      IconTab(
                        assetPath: 'assets/images/seated_person.png',
                        isSelected: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dropdown Trigger and Search Icon
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Dropdown Trigger
                  GestureDetector(
                    onTap: () {
                      _showMenuBottomSheet(context); // Show bottom sheet on tap
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          Text(
                            AppData().selectedMenu,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Search Icon
                  GestureDetector(
                    onTap: () {
                      // Handle search icon tap
                      log("Search Icon Tapped");
                    },
                    child: const Icon(
                      Icons.search,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Horizontal Scrollable List for Tabs
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: AppData().menus.map((menuItem) {
                    bool isSelected = AppData().selectedMenu == menuItem.title;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          AppData().selectedMenu =
                              menuItem.title; // Update selected menu
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 12), // Space between tabs
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.green : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? Colors.green
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              menuItem.title,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (isSelected) // Show "X" icon if selected
                              const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show bottom sheet
  void _showMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: SingleChildScrollView(
            // Wrap the entire column in a SingleChildScrollView
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Centered Dashed Line
                Center(
                  child: Container(
                    height: 2,
                    width: 40, // Adjust the width as needed
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey, // Color of the dashed line
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Title and Close Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select menu',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 36 / 32,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Menu Options
                ...AppData().menus.map((menuItem) {
                  bool isSelected = AppData().selectedMenu == menuItem.title;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        AppData().selectedMenu =
                            menuItem.title; // Update selected menu
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              isSelected ? Colors.green : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            menuItem.title,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            color: isSelected ? Colors.green : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 20),

                // Done Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            30), // Increased corner radius
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14.0,
                        horizontal:
                            60.0, // Increased horizontal padding for wider button
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8,
                          50), // Make the button wider (80% of screen width)
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
