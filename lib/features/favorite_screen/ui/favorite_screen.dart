import 'package:blank_flutter_project/features/favorite_screen/data/favorite_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blank_flutter_project/features/newsScreen/ui/widgets/news_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteNotifier = Provider.of<FavoriteNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
      ),
      body: favoriteNotifier.favoriteNews.isEmpty
          ? const Center(child: Text('No favorite news yet.'))
          : ListView.builder(
              itemCount: favoriteNotifier.favoriteNews.length,
              itemBuilder: (context, index) {
                final news = favoriteNotifier.favoriteNews[index];
                return NewsCard(topHeadlines: news);
              },
            ),
    );
  }
}
