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

  @override
  void initState() {
    super.initState();
    log('Received item: ${widget.item.title}');
    // filterAndPrepareData();
    // getMatchingItems();
    filterAndPrepareData();
  }

  void getMatchingItems() {
    // Assuming items is a Map<String, Item> where the key is the item ID
    for (var group in AppData().modifierGroups) {
      if (widget.item.modifierGroupRules.ids?.contains(group.modifierGroupID) ??
          false) {
        // If there is a match, iterate over the ModifierOptions
        for (var option in group.modifierOptions) {
          // Find the item that matches the ModifierOption ID in the Map

          if (widget.item.id == option.id) {
            log('Matching Item: ${option.id}');
          } else {
            log('Matching Item: ${widget.item.id}');
          }
        }
      }
    }
  }

  void filterAndPrepareData() {
    // Loop through items to get ModifierGroupRules
    for (var item in AppData().items) {
      // Check if ids is not null
      if (item.modifierGroupRules.ids != null) {
        // Loop through ModifierGroupRules in item to find matching ModifierGroup
        for (var modifierGroupID in item.modifierGroupRules.ids!) {
          // Find ModifierGroup by its ModifierGroupID
          var group = AppData().modifierGroups.firstWhere(
                (group) => group.modifierGroupID == modifierGroupID,
                orElse: () => ModifierGroup.empty(),
              );

          // Collect ModifierOption IDs from the ModifierGroup
          List<String> modifierOptionIds =
              group.modifierOptions.map((option) => option.id).toList();

          // Now, use these modifierOptionIds to look up the corresponding items
          for (var optionId in modifierOptionIds) {
            // Find matching item by ID
            var itemDetails = AppData().items.firstWhere(
                (item) => item.id == optionId,
                orElse: () => defaultItem // Default item
                );

            // Print out or store the item details (title, price, quantity)
            log("Item Title: ${itemDetails.title}");
            log("Price: ${itemDetails.priceInfo.price}");
            log("Quantity: Min ${itemDetails.quantityInfo.quantity.minPermitted}, Max ${itemDetails.quantityInfo.quantity.maxPermitted}");
          }
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: AppData()
            .modifierGroups
            .where((group) => group.modifierOptions.isNotEmpty)
            .map((group) {
          return Column(
            children: group.modifierOptions.map((option) {
              // Find the corresponding item by option id
              var item = AppData().items.firstWhere(
                    (i) => i.id == option.id,
                    orElse: () =>
                        defaultItem, // Fallback to defaultItem if not found
                  );

              // Validate priceInfo and quantityInfo before proceeding
              if (item.quantityInfo == null || item.priceInfo == null) {
                return Container(); // Return an empty container if quantity or price info is missing
              }

              // Get price and quantity info for the item
              var priceInfo = item.priceInfo;
              var quantityInfo = item.quantityInfo;

              // Only display if both price and quantity are valid
              if (priceInfo.price == null || quantityInfo.quantity == null) {
                return Container(); // Return empty container if price or quantity is invalid
              }

              // Collect price and quantity values
              var price = priceInfo.price?.pickupPrice ?? 0;
              var minQuantity = quantityInfo.quantity.minPermitted ?? 0;
              var maxQuantity = quantityInfo.quantity.maxPermitted ?? 0;

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
                        if (priceInfo.price != null)
                          Text(
                            "Price: Rs ${price}",
                            style: const TextStyle(fontSize: 12),
                          ),
                        // Quantity Information
                        if (quantityInfo.quantity != null)
                          Text(
                            "Min: ${minQuantity} / Max: ${maxQuantity}",
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
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
