
import 'package:flutter/material.dart';
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