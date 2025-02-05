import 'package:blank_flutter_project/core/widgets/loading_shimmer.dart';
import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:blank_flutter_project/features/newsScreen/data/news_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'news_card.dart';

class NewsListBuilder extends StatefulWidget {
  final String category;

  const NewsListBuilder({super.key, required this.category});

  @override
  State<NewsListBuilder> createState() => _NewsListBuilderState();
}

class _NewsListBuilderState extends State<NewsListBuilder> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModels>>(
      future: NewsServices(Dio())
          .getNewsByCategory(widget.category), // Fetch news by category
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(child: LoadingShimmer()),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(
            child: Center(child: Text('No news available')),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => NewsCard(topHeadlines: snapshot.data![index],),
            childCount: snapshot.data!.length,
          ),
        );
      },
    );
  }
}
