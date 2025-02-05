import 'package:blank_flutter_project/features/newsScreen/ui/widgets/news_card.dart';
import 'package:flutter/material.dart';
import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:blank_flutter_project/features/newsScreen/data/news_services.dart';
import 'package:dio/dio.dart';

class NewsSearchDelegate extends SearchDelegate<String> {
  final NewsServices newsService = NewsServices(Dio());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear search input
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, ''); // Close search
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<NewsModels>>(
      future: newsService.getNewsBySearch(query), // Fetch search results
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No results found"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return NewsCard(
              topHeadlines: snapshot.data![index],
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // No suggestions, just use results
  }
}
