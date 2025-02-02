import 'package:flutter/material.dart';

Widget categoryCard(String category) {
  // Define a map of categories and corresponding icons
  Map<String, IconData> categoryIcons = {
    'All': Icons.all_inclusive_rounded,
    'Sports': Icons.sports,
    'Politics': Icons.public,
    'Technology': Icons.computer,
    'Entertainment': Icons.movie,
    'Health': Icons.health_and_safety,
  };

  return GestureDetector(
    onTap: () {
      // Define the logic to handle the click event
      print('Clicked on $category category');
    },
    child: AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: 1.05, // Scale the card slightly to give a 3D feel when tapped
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8),

        elevation: 5, // Increase the elevation for a stronger shadow effect
        shadowColor: Colors.black.withOpacity(0.3), // Soft shadow for 3D effect
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // Create
          },
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center icon and text
                children: [
                  Icon(
                    categoryIcons[category] ??
                        Icons.category, // Default icon if category is not found
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 10), // Space between icon and text
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w500, // Medium weight for a modern feel
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
