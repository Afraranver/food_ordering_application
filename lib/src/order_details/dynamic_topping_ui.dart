import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/models/item_model.dart';
import 'package:food_ordering_application/src/models/modifiergroup_model.dart';
import 'package:food_ordering_application/src/util/appdata.dart';
import 'package:food_ordering_application/src/util/helper.dart';

class DynamicToppingUI extends StatefulWidget {
  final Item item;
  const DynamicToppingUI({super.key, required this.item});

  @override
  _DynamicToppingUIState createState() => _DynamicToppingUIState();
}

class _DynamicToppingUIState extends State<DynamicToppingUI> {
  Map<String, int> itemQuantities = {};
  List<Item> filteredItems = [];

  void filterAndPrepareData() {
    filteredItems.clear();

    if (hasContentToShow(widget.item)) {
      for (var modifierGroupID in widget.item.modifierGroupRules.ids!) {
        var group = AppData().modifierGroups.firstWhere(
              (group) => group.modifierGroupID == modifierGroupID,
              orElse: () => ModifierGroup.empty(),
            );

        List<String> modifierOptionIds =
            group.modifierOptions.map((option) => option.id).toList();

        for (var optionId in modifierOptionIds) {
          var itemDetails = AppData().items.firstWhere(
                (item) => item.menuItemId == optionId,
                orElse: () => defaultItem,
              );

          filteredItems.add(itemDetails);
        }
      }
    } else {
      log("No content to show for item: ${widget.item.title}");
    }
  }

  void incrementQuantity(String itemId) {
    setState(() {
      itemQuantities[itemId] = (itemQuantities[itemId] ?? 0) + 1;
    });
  }

  void decrementQuantity(String itemId) {
    setState(() {
      if (itemQuantities[itemId]! > 0) {
        itemQuantities[itemId] = (itemQuantities[itemId]! - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    filterAndPrepareData();

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          var item = filteredItems[index];

          // Collect price and quantity values
          var price = item.priceInfo.price.pickupPrice;

          // Store the quantity for the item (if it's the first time, set to 0)
          itemQuantities.putIfAbsent(item.id, () => 0);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    color: Color(0xFF171725),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 36 / 32,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Price Information
                    Text(
                      "Price: Rs $price",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Decrement Quantity Button
                    GestureDetector(
                      onTap: () => decrementQuantity(item.id),
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: _isDecrementPressed(itemQuantities, item.id)
                              ? Colors.green
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _isDecrementPressed(itemQuantities, item.id)
                                ? Colors.green
                                : Colors.black,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: _isDecrementPressed(itemQuantities, item.id)
                              ? Colors.white
                              : Colors.black,
                          size: 20, // Change icon color when pressed
                        ),
                      ),
                    ),
                    // Add space between Decrement button and Quantity text
                    const SizedBox(
                        width: 10), // Adjust this value to your desired space

                    // Display current quantity
                    Text(
                      itemQuantities[item.id].toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 16),
                    ),
                    // Add space between Quantity text and Increment button
                    const SizedBox(
                        width: 10), // Adjust this value to your desired space

                    // Increment Quantity Button
                    GestureDetector(
                      onTap: () => incrementQuantity(item.id),
                      child: Container(
                        padding: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: _isIncrementPressed(itemQuantities, item.id)
                              ? Colors.green
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _isIncrementPressed(itemQuantities, item.id)
                                ? Colors.green
                                : Colors.black,
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.add,
                          color: _isIncrementPressed(itemQuantities, item.id)
                              ? Colors.white
                              : Colors.black,
                          size: 20, // Change icon color when pressed
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

bool _isDecrementPressed(Map<String, int> itemQuantities, String itemId) {
  return itemQuantities[itemId]! > 0;
}

bool _isIncrementPressed(Map<String, int> itemQuantities, String itemId) {
  return itemQuantities[itemId]! < 100;
}
