class NewsModels {
  final String title;
  final String? description;
  final String? image;
  final SourceModules source;

  NewsModels(
      {required this.title,
      required this.description,
      required this.image,
      required this.source});

  factory NewsModels.fromJson(Map<String, dynamic> json) {
    return NewsModels(
        title: json['title'],
        description: json['description'],
        image: json['urlToImage'],
        source: SourceModules.fromJson(
          json['source'],
        ));
  }
}

class SourceModules {
  String id;
  String name;

  SourceModules({required this.id, required this.name});

  factory SourceModules.fromJson(Map<String, dynamic> json) {
    return SourceModules(
      id: json['id'],
      name: json['name'],
    );
  }
}
