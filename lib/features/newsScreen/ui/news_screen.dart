import 'package:flutter/material.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/categories_list.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/news_list_builder.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/news_search_delegate.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  String selectedCategory = 'general'; // Default category

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Today News",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showSearch(
                context: context,
                delegate: NewsSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: CategoriesList(
              selectedCategory: selectedCategory,
              onCategorySelected: onCategorySelected,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 5)),
          NewsListBuilder(category: selectedCategory),
        ],
      ),
    );
  }
}
