import 'package:blank_flutter_project/features/newsScreen/data/news_data.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/build_category_card.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/build_news_card.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample dynamic data
    final List<NewsItem> newsList = [
      NewsItem(
        imageUrl:
            'https://images7.alphacoders.com/929/thumb-1920-929970.jpg', // Replace with actual image URL
        title: 'Breaking News 1',
        description:
            'Short description of news. This is a brief summary of the news article to give users a quick preview.',
      ),
      NewsItem(
        imageUrl:
            'https://images7.alphacoders.com/929/thumb-1920-929970.jpg', // Replace with actual image URL
        title: 'Breaking News 2',
        description:
            'Short description of news. This is a brief summary of the news article to give users a quick preview.',
      ),
      NewsItem(
        imageUrl:
            'https://images7.alphacoders.com/929/thumb-1920-929970.jpg', // Replace with actual image URL
        title: 'Breaking News 3',
        description:
            'Short description of news. This is a brief summary of the news article to give users a quick preview.',
      ),
      // Add more dynamic news items here
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child:
                SizedBox(height: 10), // Adjust the height to the desired space
          ),
          // Horizontal Category List
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildCategory('Sports'),
                  buildCategory('Politics'),
                  buildCategory('Technology'),
                  buildCategory('Entertainment'),
                  buildCategory('Health'),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child:
                SizedBox(height: 5), // Adjust the height to the desired space
          ),
          // News List
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: buildNewsCard(newsList[index]),
              ),
              childCount: newsList.length,
            ),
          ),
        ],
      ),
    );
  }
}
