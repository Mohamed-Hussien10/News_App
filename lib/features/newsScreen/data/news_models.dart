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

  // Factory method to create an instance from JSON
  factory NewsModels.fromJson(Map<String, dynamic> json) {
    return NewsModels(
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ??
          'https://static.vecteezy.com/system/resources/previews/001/234/420/non_2x/breaking-news-on-mesh-background-vector.jpg',
    );
  }

  // Method to convert an instance into JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': imageUrl,
    };
  }
}
