class Movie {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String duration;
  final String uploadTime;
  final String views;
  final String author;
  final String description;
  final String subscriber;
  final bool isLive;

  Movie({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.uploadTime,
    required this.views,
    required this.author,
    required this.description,
    required this.subscriber,
    required this.isLive,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      duration: json['duration'],
      uploadTime: json['uploadTime'],
      views: json['views'],
      author: json['author'],
      description: json['description'],
      subscriber: json['subscriber'],
      isLive: json['isLive'],
    );
  }
}
