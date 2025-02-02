import 'package:blank_flutter_project/features/newsScreen/ui/widgets/categories_list.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/news_list_builder.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          // Horizontal Category List
          CategoriesList(),
          SliverToBoxAdapter(child: SizedBox(height: 5)),
          // News List
          NewsListBuilder(),
        ],
      ),
    );
  }
}
