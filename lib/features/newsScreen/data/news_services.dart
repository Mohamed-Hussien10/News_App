import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewsServices {
  final Dio dio;
  final String baseUrl = 'https://newsapi.org/v2';

  NewsServices(this.dio);

  Future<List<NewsModels>> getTopHeadlines() async {
    return await _fetchNews('$baseUrl/top-headlines', {
      'country': 'us', // Default country
    });
  }

  Future<List<NewsModels>> getNewsByCategory(String category) async {
    if (category == 'general') return await getTopHeadlines();

    return await _fetchNews('$baseUrl/top-headlines', {
      'category': category,
    });
  }

  Future<List<NewsModels>> getNewsBySearch(String query) async {
    return await _fetchNews('$baseUrl/everything', {
      'q': query,
    });
  }

  /// **Private method to handle API calls**
  Future<List<NewsModels>> _fetchNews(
      String url, Map<String, dynamic> queryParams) async {
    try {
      final String apiKey = dotenv.env['API_KEY_NEWS'] ?? "";
      if (apiKey.isEmpty) {
        throw Exception("Missing API Key");
      }

      queryParams['apiKey'] = apiKey;

      Response response = await dio.get(url, queryParameters: queryParams);

      if (response.statusCode == 200) {
        List<dynamic> articles = response.data['articles'];
        return articles.map((json) => NewsModels.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch news: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("Dio Error: ${e.message}");
      return [];
    } catch (e) {
      print("Error fetching news: $e");
      return [];
    }
  }
}
