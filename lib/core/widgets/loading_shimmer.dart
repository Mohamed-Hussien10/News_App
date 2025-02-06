import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the current theme is dark mode
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Set shimmer colors based on the theme
    Color baseColor = isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;
    Color highlightColor = isDarkMode ? Colors.grey[600]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor, // Adjusted base color for dark mode
      highlightColor: highlightColor, // Adjusted highlight color for dark mode
      child: Column(
        children: List.generate(5, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? Colors.grey[850]
                  : Colors.white, // Adjusted background color for dark mode
              borderRadius: BorderRadius.circular(12),
            ),
          );
        }),
      ),
    );
  }
}
