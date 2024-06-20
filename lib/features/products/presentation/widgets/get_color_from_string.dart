import 'package:flutter/material.dart';

Color getColorFromName(String colorName) {
  final colorMap = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'pink': Colors.pink,
    'white': Colors.white,
    'black': Colors.black
    // Add more colors as needed
  };

  return colorMap[colorName.toLowerCase()] ??
      Colors.grey; // Default color if not found
}
