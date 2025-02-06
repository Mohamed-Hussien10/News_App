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
        backgroundColor: Theme.of(context)
            .appBarTheme
            .backgroundColor, // Uses theme background color
        elevation:
            Theme.of(context).appBarTheme.elevation, // Uses theme elevation
        scrolledUnderElevation: Theme.of(context)
            .appBarTheme
            .scrolledUnderElevation, // Uses theme scrolledUnderElevation
        foregroundColor: Theme.of(context)
            .appBarTheme
            .foregroundColor, // Uses theme foreground color
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
