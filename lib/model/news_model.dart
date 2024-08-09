class News {
  int? id;
  String? title;
  String? description;
  String? author;
  String? url;
  String? image;
  String? publishDate;

  News({
    this.id,
    this.title,
    this.description,
    this.author,
    this.url,
    this.image,
    this.publishDate,
  });

  // Factory constructor to create a News object from a JSON map
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      author: json['author'] ?? 'Unknown',
      url: json['url'] ?? '',
      image: json['urlToImage'] ?? '',
      publishDate: json['publishedAt'] ?? '',
    );
  }

  // Method to convert a News object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'author': author,
      'url': url,
      'urlToImage': image,
      'publishedAt': publishDate,
    };
  }

  // Method to create a copy of the News object with modified fields
  News copyWith({
    int? id,
    String? title,
    String? description,
    String? author,
    String? url,
    String? image,
    String? publishDate,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      author: author ?? this.author,
      url: url ?? this.url,
      image: image ?? this.image,
      publishDate: publishDate ?? this.publishDate,
    );
  }
}
