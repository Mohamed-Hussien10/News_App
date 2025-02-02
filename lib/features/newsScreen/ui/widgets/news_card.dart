import 'package:blank_flutter_project/features/newsScreen/data/news_models.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final NewsModels topHeadlines;
   const NewsCard({super.key,required this.topHeadlines});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Column(
        children: [
          // News Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              topHeadlines.imageUrl, // Use dynamic image URL
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // News Title and Description
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topHeadlines.title, // Use dynamic title
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  topHeadlines.description, // Use dynamic description
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
