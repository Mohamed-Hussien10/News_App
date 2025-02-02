class NewsModels {
  final String title;
  final String description;
  final String url;
  final String imageUrl;

  NewsModels({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
  });

  factory NewsModels.fromJson(Map<String, dynamic> json) {
    return NewsModels(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
    );
  }
}
