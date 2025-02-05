import 'package:flutter/material.dart';

// Define a map of category names to icons
final Map<String, IconData> categoryIcons = {
  'general': Icons.all_inclusive_rounded,
  'sports': Icons.sports,
  'politics': Icons.public,
  'technology': Icons.computer,
  'entertainment': Icons.movie,
  'health': Icons.health_and_safety,
  'science': Icons.science,
  'business': Icons.business,
};

class CategoryCard extends StatelessWidget {
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: 1.05, // Scale the card slightly for 3D effect when tapped
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        elevation: 5, // Stronger shadow for 3D effect
        shadowColor: Colors.black.withOpacity(0.3), // Soft shadow
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap, // Handle tap here
          child: Ink(
            height: 0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    categoryIcons[category] ?? Icons.category,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    category.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
