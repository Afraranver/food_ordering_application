import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/models/item_model.dart';
import 'package:food_ordering_application/src/models/modifiergroup_model.dart';
import 'package:food_ordering_application/src/util/appdata.dart';

class DynamicToppingUI extends StatefulWidget {
  final Item item;
  const DynamicToppingUI({super.key, required this.item});

  @override
  _DynamicToppingUIState createState() => _DynamicToppingUIState();
}

class _DynamicToppingUIState extends State<DynamicToppingUI> {
  Map<String, int> itemQuantities = {};
  List<Item> filteredItems = [];
  // @override
  // void initState() {
  //   super.initState();
  //   log('Received item: ${widget.item.title}');
  //   filterAndPrepareData(widget.item);
  // }

  void filterAndPrepareData() {
    // Log the received item title for debugging
    log('Received item: ${widget.item.title}');

    // Clear the list to avoid duplication
    filteredItems.clear();

    // Check if the item has modifierGroupRules with IDs
    if (widget.item.modifierGroupRules.ids != null) {
      // Loop through ModifierGroupRules IDs
      for (var modifierGroupID in widget.item.modifierGroupRules.ids!) {
        // Find the ModifierGroup by its ID
        var group = AppData().modifierGroups.firstWhere(
              (group) => group.modifierGroupID == modifierGroupID,
              orElse: () => ModifierGroup.empty(),
            );

        // Collect ModifierOption IDs from the ModifierGroup
        List<String> modifierOptionIds =
            group.modifierOptions.map((option) => option.id).toList();

        // Loop through ModifierOption IDs to fetch details of associated items
        for (var optionId in modifierOptionIds) {
          // Find the item by ID in the list
          var itemDetails = AppData().items.firstWhere(
                (item) => item.menuItemId == optionId,
                orElse: () => defaultItem, // Default item if not found
              );

          // Add the valid item to the filteredItems list
          filteredItems.add(itemDetails);

          // Optional: Log details of the found item
          log("Item Title: ${itemDetails.title}");
          log("Price: ${itemDetails.priceInfo.price}");
          log("Quantity: Min ${itemDetails.quantityInfo.quantity.minPermitted}, Max ${itemDetails.quantityInfo.quantity.maxPermitted}");
        }
      }
    }
  }

  // Function to increment the quantity of an item
  void incrementQuantity(String itemId) {
    setState(() {
      itemQuantities[itemId] = (itemQuantities[itemId] ?? 0) + 1;
    });
  }

  // Function to decrement the quantity of an item
  void decrementQuantity(String itemId) {
    setState(() {
      if (itemQuantities[itemId]! > 0) {
        itemQuantities[itemId] = (itemQuantities[itemId]! - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Prepare and filter data before rendering the UI
    filterAndPrepareData();

    return Scaffold(
      appBar: null,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          var item = filteredItems[index];

          // Collect price and quantity values
          var price = item.priceInfo.price.pickupPrice;
          var minQuantity = item.quantityInfo.quantity.minPermitted;
          var maxQuantity = item.quantityInfo.quantity.maxPermitted;

          // Store the quantity for the item (if it's the first time, set to 0)
          itemQuantities.putIfAbsent(item.id, () => 0);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.title, style: const TextStyle(fontSize: 16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Price Information
                    Text(
                      "Price: Rs $price",
                      style: const TextStyle(fontSize: 12),
                    ),
                    // Quantity Information
                    Text(
                      "Min: $minQuantity / Max: $maxQuantity",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Decrement Quantity Button
                    IconButton(
                      onPressed: () => decrementQuantity(item.id),
                      icon: const Icon(Icons.remove, color: Colors.green),
                    ),
                    // Display current quantity
                    Text(
                      itemQuantities[item.id].toString().padLeft(2, '0'),
                      style: const TextStyle(fontSize: 16),
                    ),
                    // Increment Quantity Button
                    IconButton(
                      onPressed: () => incrementQuantity(item.id),
                      icon: const Icon(Icons.add, color: Colors.green),
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
