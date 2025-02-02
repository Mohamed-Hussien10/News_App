import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/news_card.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  final List<NewsModels> topHeadlines;
  const NewsList({
    super.key,
    required this.topHeadlines,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: NewsCard(topHeadlines: topHeadlines[index]),
        ),
        childCount: topHeadlines.length,
      ),
    );
  }
}
