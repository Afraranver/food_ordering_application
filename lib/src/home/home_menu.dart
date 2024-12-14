import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/home/menu_item_card.dart';
import 'package:food_ordering_application/src/util/appdata.dart';
import 'package:food_ordering_application/src/util/helper.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();
 int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    // Ensure that the data is loaded before continuing
    _initializeData();
  }

  void _onIconTap(int index) {
    setState(() {
      _selectedIndex = index; // Update selected index
    });
  }

  Future<void> _initializeData() async {
    // Wait for data to load
    await AppData().loadData();

    // Once the data is loaded, filter categories for the selected menu
    if (AppData().menus.isNotEmpty) {
      AppData().selectedMenu = AppData().menus[0].title;
      filterCategoriesForMenu(AppData().selectedMenu);
    }
  }

  void filterCategoriesForMenu(String menuTitle) {
    final menu = AppData().menus.firstWhere((m) => m.title == menuTitle);
    setState(() {
      AppData().displayedCategories = AppData()
          .categories
          .where((category) =>
              menu.menuCategoryIDs.contains(category.menuCategoryID))
          .toList();

      // Optionally pre-select the first category
      if (AppData().displayedCategories.isNotEmpty) {
        // AppData().selectedCategory = AppData().displayedCategories[0].title;
        AppData().selectedCategory = AppData().displayedCategories.first.title;
        AppData().filteredItems = getFilteredItems(
          AppData().displayedCategories.first,
          AppData().items,
        );
      }
    });
  }

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

                  Row(
                    children: [
                      // Show the search icon
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSearchVisible =
                                !_isSearchVisible; // Toggle search field visibility
                          });
                        },
                        child: const Icon(
                          Icons.search,
                          size: 24,
                          color: Colors.black,
                        ),
                      ),
                      // Show the input field when _isSearchVisible is true
                      if (_isSearchVisible)
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0), // Small space between icon and input
                          child: SizedBox(
                            width: 150, // Adjust width of the input field
                            child: TextField(
                              controller: _searchController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Search...",
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    setState(() {
                                      _searchController
                                          .clear(); // Clear the search text
                                      _isSearchVisible =
                                          false; // Hide the input field
                                    });
                                  },
                                ),
                              ),
                              onSubmitted: (query) {
                                log("Searching for: $query"); // Perform search or handle the input
                              },
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),

            // Horizontal Scrollable List for Filtered Categories
            if (AppData().displayedCategories.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Make the tabs horizontally scrollable
                  child: Container(
                    alignment:
                        Alignment.centerLeft, // Align content to the left
                    child: Row(
                      children: AppData().displayedCategories.map((category) {
                        bool isCategorySelected =
                            AppData().selectedCategory == category.title;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              AppData().selectedCategory = category.title;
                              AppData().filteredItems = getFilteredItems(
                                category,
                                AppData().items,
                              );
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                right: 12), // Space between tabs
                            padding: const EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal:
                                    12), // Reduced padding for smaller size
                            decoration: BoxDecoration(
                              color: isCategorySelected
                                  ? Colors.green
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: isCategorySelected
                                    ? Colors.green
                                    : Colors.grey.shade300,
                                width: isCategorySelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Category title with smaller font size
                                Text(
                                  category.title,
                                  style: TextStyle(
                                    color: isCategorySelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 12, // Smaller font size
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // If the category is selected, show the 'X' icon to deselect it
                                if (isCategorySelected)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      // Handle deselecting logic
                                    },
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            if (AppData().displayedCategories.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text("No categories available."),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: AppData().filteredItems.map((item) {
                  return MenuItemCard(
                    item: item,
                  );
                }).toList(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Basket Summary Button with margin on left and right
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16), // Margin added
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFF1CAE81), // Green color for basket summary
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Basket • 3 items • Rs 1024.00",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 36 / 32,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Space between buttons
                  // View Basket Button with margin on left and right
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16), // Margin added
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFF4F6F9), // Light grey background for "View Basket"
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                          color: const Color(0xFF1CAE81)), // Green border
                    ),
                    child: const Text(
                      "View Basket",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        color: Color(0xFF1CAE81),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 36 / 32,
                      ),
                    ),
                  ),
                ],
              ),
            )
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
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
            decoration: const BoxDecoration(
              color: Colors.white, // Set the background color to white
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20)), // Ensure top corners are rounded
            ), // Set the background color to white
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
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
                      bool isSelected =
                          AppData().selectedMenu == menuItem.title;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            AppData().selectedMenu =
                                menuItem.title; // Update selected menu
                            filterCategoriesForMenu(AppData().selectedMenu);
                            // AppData().filteredItems = getFilteredItems(AppData().selectedCategory, AppData().items);
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
                              color: isSelected
                                  ? Colors.green
                                  : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Title with flexible width and error handling
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      menuItem.title,
                                      maxLines:
                                          1, // Ensure it stays in a single line
                                      overflow: TextOverflow
                                          .ellipsis, // Truncate with "..."
                                      style: const TextStyle(
                                        fontFamily: 'Urbanist',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        height: 36 / 32,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Time Availability (if available for today)
                              if (AppData().todayTimeRange != null)
                                Text(
                                  '${formatTime(AppData().todayTimeRange!.startTime)} - ${formatTime(AppData().todayTimeRange!.endTime)}',
                                  style: const TextStyle(
                                    fontFamily: 'Urbanist',
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 36 / 32,
                                  ),
                                ),

                              // Radio button icon
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
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.8,
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
            ));
      },
    );
  }
}
