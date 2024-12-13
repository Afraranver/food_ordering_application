import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/models/item_model.dart';
import 'package:food_ordering_application/src/order_details/order_details_page.dart';

class MenuItemCard extends StatelessWidget {
  final Item item;

  const MenuItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 2, // Reduced elevation to reduce the shadow effect
      color: Colors.white, // Set background color to white
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          navigateToOrderDetails(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        color: Color(0xFF060606),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 36 / 32,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Description
                    Text(
                      item.description,
                      style: const TextStyle(
                        fontFamily: 'Urbanist',
                        color: Color(0xFF060606),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 36 / 32,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Price and Promotions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Price
                        Text(
                          'Rs ${item.priceInfo.price.pickupPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontFamily: 'Quicksand',
                            color: Color(0xFF1CAE81),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            height: 36 / 32,
                          ),
                        ),

                        // Add some space between price and promotions
                        const SizedBox(width: 16),
                        // Promotions
                        if (item.modifierGroupRules.isNotEmpty)
                          Expanded(
                            // Wrap in Expanded to take up available space
                            child: Align(
                              alignment: Alignment
                                  .centerRight, // Align to the right side
                              child: Container(
                                constraints: const BoxConstraints(
                                  maxWidth:
                                      200, // Set a maximum width for the container
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFB200),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "${item.modifierGroupRules.ids!.length} Promotions Available",
                                  style: const TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: Color(0xFF141414),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    height: 36 / 32,
                                  ),
                                  overflow: TextOverflow
                                      .ellipsis, // Add ellipsis when text overflows
                                  maxLines: 1, // Limit to one line
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void navigateToOrderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the modal to occupy full screen height
      backgroundColor: Colors.transparent, // Makes the background transparent for rounded corners
      builder: (context) => OrderDetails(item: item), // Pass the item here
    );
  }
}
