import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/models/category_model.dart';
import 'package:food_ordering_application/src/models/item_model.dart';
import 'package:intl/intl.dart';


String formatTime(String time24) {
  // Parse the time string in "HH:mm" format to a DateTime object
  final DateTime parsedTime = DateFormat('HH:mm').parse(time24);

  // Format the DateTime object to a 12-hour time with AM/PM
  return DateFormat('h:mm a').format(parsedTime);
}

Widget customRadioButton(bool isSelected) {
  return Container(
    width: 24, // Adjust size as needed
    height: 24,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isSelected ? Colors.green : Colors.grey.shade300, // Outer circle color
    ),
    child: Center(
      child: Container(
        width: 12, // Adjust inner dot size
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.transparent, // Inner dot color
        ),
      ),
    ),
  );
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

List<Item> getFilteredItems(Category category, List<Item> items) {
  // Extract MenuEntities IDs from the selected category
  List<String> menuEntityIds = category.menuEntities
      .where((entity) => entity.type == "ITEM") // Ensure it's of type ITEM
      .map((entity) => entity.id)
      .toList();

  // Find matching items from the provided items list
  return items.where((item) {
    return menuEntityIds.contains(item.menuItemId);
  }).toList();
}

class NutrientColumn extends StatelessWidget {
  final String label;
  final String value;

  const NutrientColumn({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

bool hasContentToShow(Item item) {
  bool hasContent = item.modifierGroupRules.ids != null &&
      item.modifierGroupRules.ids!.any((id) => id.isNotEmpty);

  // Log the evaluation result for debugging
  if (hasContent) {
    log("Item ${item.title} has content to show.");
  } else {
    log("Item ${item.title} does not have content to show.");
  }

  return hasContent;
}

class IconTabHome extends StatelessWidget {
  final String unselectedAssetPath;
  final String selectedAssetPath;
  final bool isSelectedIcon;

  const IconTabHome({
    required this.unselectedAssetPath,
    required this.selectedAssetPath,
    required this.isSelectedIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      isSelectedIcon ? selectedAssetPath : unselectedAssetPath,
      width: 24,
      height: 24,
    );
  }
}