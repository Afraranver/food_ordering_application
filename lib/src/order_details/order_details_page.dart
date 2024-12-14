import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/models/item_model.dart';
import 'package:food_ordering_application/src/order_details/add_to_cart_page.dart';
import 'package:food_ordering_application/src/order_details/dynamic_topping_ui.dart';
import 'package:food_ordering_application/src/util/helper.dart';

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
                              fit: BoxFit.contain,
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
                                    overflow: TextOverflow
                                        .ellipsis, // Add ellipsis when text overflows
                                    maxLines: 1,
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
                          SingleChildScrollView(
                            // Wrap the entire content inside a scroll view
                            child: Column(
                              children: [
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double
                                            .infinity, // Full width for the TabBar
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
                                      const SizedBox(height: 8.0),
                                      SizedBox(
                                        height:
                                            120.0, // Adjust according to content
                                        child: TabBarView(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (item
                                                      .dishInfo
                                                      .classifications
                                                      .ingredients
                                                      .isNotEmpty)
                                                    // If ingredients are present, show them in chips
                                                    Wrap(
                                                      spacing:
                                                          8.0, // Adjust space between chips
                                                      runSpacing:
                                                          4.0, // Adjust space between lines of chips
                                                      children: item
                                                          .dishInfo
                                                          .classifications
                                                          .ingredients
                                                          .map((ingredient) {
                                                        return Chip(
                                                          label: Center(
                                                            child: Text(
                                                                ingredient),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    )
                                                  else
                                                    // If no ingredients, show an empty state message centered
                                                    const Center(
                                                      child: Text(
                                                        'No ingredients listed.',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                                  // 'See more' button with arrow
                                                  TextButton(
                                                    onPressed: () {},
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center, // Center align the text and icon
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Align(
                                                    alignment: Alignment
                                                        .centerLeft, // Align text to the left
                                                    child: Text(
                                                      'Nutritional Info per 100g', // You can add a header if needed
                                                      style: TextStyle(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            Color(0xFF171725),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 36 / 32,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          10), // Adds spacing between the header and the row
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween, // Distribute space evenly
                                                    children: [
                                                      NutrientColumn(
                                                          label: 'Kcal',
                                                          value: item
                                                              .nutrientData
                                                              .calories
                                                              .displayType
                                                              .toString()),
                                                      NutrientColumn(
                                                          label: 'Proteins',
                                                          value: item
                                                              .nutrientData
                                                              .calories
                                                              .displayType
                                                              .toString()),
                                                      NutrientColumn(
                                                          label: 'Fats',
                                                          value: item
                                                              .nutrientData
                                                              .calories
                                                              .displayType
                                                              .toString()),
                                                      NutrientColumn(
                                                          label: 'Carbo H',
                                                          value: item
                                                              .nutrientData
                                                              .calories
                                                              .displayType
                                                              .toString()),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (item
                                                      .dishInfo
                                                      .classifications
                                                      .instructionsForUse
                                                      .isNotEmpty)
                                                    // If instructionsForUse is present, display it as text
                                                    Text(
                                                      item
                                                          .dishInfo
                                                          .classifications
                                                          .instructionsForUse,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black87,
                                                        height:
                                                            1.5, // Adjust line height
                                                      ),
                                                    )
                                                  else
                                                    // If no instructions, show an empty state message centered
                                                    const Center(
                                                      child: Text(
                                                        'No instructions for use provided.',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (item.allergens.isNotEmpty)
                                                    // If allergens are present, display them in a Wrap with chips
                                                    Wrap(
                                                      spacing:
                                                          8.0, // Space between chips
                                                      runSpacing:
                                                          4.0, // Space between lines of chips
                                                      children: item.allergens
                                                          .map((allergen) {
                                                        return Chip(
                                                          label: Text(
                                                            allergen,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    )
                                                  else
                                                    // If no allergens, show an empty state message centered
                                                    const Center(
                                                      child: Text(
                                                        'No allergens listed.',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      if (hasContentToShow(
                                          item)) 
                                        SizedBox(
                                          height:
                                              200, 
                                          child: DynamicToppingUI(item: item),
                                        ),
                                      const SizedBox(height: 20),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: AddToCartPage(),
                                      ),
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
