import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:blank_flutter_project/features/newsScreen/data/news_services.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/error_message.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/news_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsListBuilder extends StatefulWidget {
  const NewsListBuilder({super.key});

  @override
  State<NewsListBuilder> createState() => _NewsListBuilderState();
}

class _NewsListBuilderState extends State<NewsListBuilder> {
  var future;
  @override
  void initState() {
    super.initState();
    future = NewsServices(Dio()).getTopHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModels>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return NewsList(topHeadlines: snapshot.data!);
        } else if (snapshot.hasError) {
          return const SliverToBoxAdapter(child: ErrorMessage());
        } else {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
