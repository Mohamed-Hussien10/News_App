import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsServices {
  final Dio dio;

  NewsServices(this.dio);

  Future<List<NewsModels>> getTopHeadlines() async {
    try {
      final String apiKey = dotenv.env['API_KEY_NEWS'] ?? "";
      if (apiKey.isEmpty) {
        throw Exception("API Key is missing");
      }

      Response response = await dio.get(
        'https://newsapi.org/v2/top-headlines',
        queryParameters: {'country': 'us', 'apiKey': apiKey},
      );

      List<dynamic> articles = response.data['articles'];
      List<NewsModels> newsList =
          articles.map((json) => NewsModels.fromJson(json)).toList();

      return newsList;
    } catch (e) {
      print("Error fetching news: $e"); // Better error logging
      return [];
    }
  }
}
