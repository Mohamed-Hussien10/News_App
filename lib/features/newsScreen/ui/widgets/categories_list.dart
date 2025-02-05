import 'package:flutter/material.dart';
import 'category_card.dart';

class CategoriesList extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  CategoriesList({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  final List<String> categories = [
    'general',
    'business',
    'sports',
    'health',
    'science',
    'technology',
    'entertainment',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected =
              category.toLowerCase() == selectedCategory.toLowerCase();

          return CategoryCard(
            category: category,
            isSelected: isSelected,
            onTap: () => onCategorySelected(category.toLowerCase()),
          );
        },
      ),
    );
  }
}
