import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsServices {
  Dio dio;

  NewsServices(this.dio);

  Future<List<NewsModels>> getTopHeadlines() async {
    final String apiKey = dotenv.env['API_KEY_NEWS'] ?? "";
    Response response = await dio
        .get('https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey');

    Map<String, dynamic> responseData = response.data['response'];
    List<dynamic> articles = responseData['articles'];
    List<NewsModels> newsList =
        articles.map((json) => NewsModels.fromJson(json)).toList();

    return newsList;
  }
}
