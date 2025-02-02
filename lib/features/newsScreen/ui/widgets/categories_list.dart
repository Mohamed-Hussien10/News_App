import 'package:blank_flutter_project/features/newsScreen/ui/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        height: 60,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            categoryCard('All'),
            categoryCard('Sports'),
            categoryCard('Politics'),
            categoryCard('Technology'),
            categoryCard('Entertainment'),
            categoryCard('Health'),
          ],
        ),
      ),
    );
  }
}
