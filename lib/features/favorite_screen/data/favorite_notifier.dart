import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<NewsModels> _favoriteNews = [];

  List<NewsModels> get favoriteNews => _favoriteNews;

  // Load favorites from SharedPreferences
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteNewsJson = prefs.getStringList('favorite_news');

    if (favoriteNewsJson != null) {
      _favoriteNews = favoriteNewsJson
          .map((jsonStr) => NewsModels.fromJson(jsonDecode(jsonStr)))
          .toList();
      notifyListeners();
    }
  }

  // Add or remove a favorite
  Future<void> toggleFavorite(NewsModels news) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favoriteNewsJson = prefs.getStringList('favorite_news');
    List<String> updatedFavorites = favoriteNewsJson ?? [];

    if (_favoriteNews.any((item) => item.title == news.title)) {
      // Remove from favorites
      updatedFavorites.removeWhere((jsonStr) {
        final item = NewsModels.fromJson(jsonDecode(jsonStr));
        return item.title == news.title;
      });
    } else {
      // Add to favorites
      updatedFavorites.add(jsonEncode(news.toJson()));
    }

    // Save updated favorites to SharedPreferences
    await prefs.setStringList('favorite_news', updatedFavorites);

    // Update the local list and notify listeners
    _favoriteNews = updatedFavorites
        .map((jsonStr) => NewsModels.fromJson(jsonDecode(jsonStr)))
        .toList();
    notifyListeners();
  }

  // Check if a news item is favorited
  bool isFavorite(NewsModels news) {
    return _favoriteNews.any((item) => item.title == news.title);
  }
}
