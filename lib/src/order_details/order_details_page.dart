import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/models/item_model.dart';

class OrderDetails extends StatelessWidget {
  final Item item;

  const OrderDetails({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95, // Start with 95% of the screen height
      maxChildSize: 1.0, // Allow full expansion
      minChildSize: 0.8, // Allow contraction to 80%
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20), // Rounded corners at the top
          ),
          child: Scaffold(
            backgroundColor: Colors.white, // Background color for the modal
            body: Column(
              children: [
                // Header with Close Button on the Left
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Align close button to the left
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(); // Close the modal
                        },
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                      const Spacer(), // Push remaining content to the right
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    controller:
                        scrollController, // Attach the scroll controller
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              item.imageUrl, // Use the item's image
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title, // Use the item's name
                                    style: const TextStyle(
                                      fontFamily: 'Urbanist',
                                      color: Color(0xFF171725),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      height: 36 / 32,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/location.png', // Path to your asset image
                                        height: 16.0, // Set the height
                                        width:
                                            16.0, // Set the width (optional, for consistent size)
                                      ),
                                      const SizedBox(width: 4.0),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Rs ${item.priceInfo.price.pickupPrice}', // Use the item's price
                                    style: const TextStyle(
                                      fontFamily: 'Urbanist',
                                      color: Color(0xFF171725),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      height: 36 / 32,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/star.png', // Path to your asset image
                                        height: 16.0, // Set the height
                                        width:
                                            16.0, // Set the width (optional, for consistent size)
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        item.totalReviews.toStringAsFixed(
                                            1), // Use the item's rating
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF201A18),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          height: 36 / 32,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            item.description, // Use the item's description
                            style: const TextStyle(
                              fontFamily: 'Urbanist',
                              color: Color(0xFF434E58),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 36 / 32,
                            ),
                          ),

                          const SizedBox(height: 16.0),
                          // Tabs for different sections (Ingredients, Nutritional, etc.)
                          DefaultTabController(
                            length: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container to ensure no side margins
                                Container(
                                  width: double
                                      .infinity, // Make sure it takes the full width
                                  padding: EdgeInsets
                                      .zero, // No padding around the TabBar
                                  child: const TabBar(
                                    labelColor: Color(
                                        0xFF1CAE81), // Selected tab label color
                                    unselectedLabelColor: Color(
                                        0xFF171725), // Unselected tab label color
                                    indicatorColor: Color(
                                        0xFF1CAE81), // Color of the indicator (underline)
                                    labelStyle: TextStyle(
                                      fontFamily: 'Urbanist',
                                      color: Color(0xFF434E58),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 36 / 32,
                                    ),
                                    tabs: [
                                      Tab(text: 'Ingredients'),
                                      Tab(text: 'Nutritional'),
                                      Tab(text: 'Instructions'),
                                      Tab(text: 'Allergies'),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 250.0, // Adjust according to content
                                  child: TabBarView(
                                    children: [
                                      // Ingredients Tab
                                      Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Chip(label: Text('Eggs')),
                                            const Chip(label: Text('Milk')),
                                            const Chip(label: Text('Mollusks')),
                                            const Chip(label: Text('Mustard')),
                                            const Chip(label: Text('Gluten')),
                                            TextButton(
                                              onPressed: () {},
                                              child: const Text('See more'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Nutritional Tab
                                      const Center(
                                          child: Text('Nutritional Info here')),
                                      // Instructions Tab
                                      const Center(
                                          child: Text('Instructions here')),
                                      // Allergies Tab
                                      const Center(
                                          child: Text('Allergies info here')),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
