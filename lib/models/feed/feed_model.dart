class FeedResponse {
  final int id;
  final int userId;
  final int likeCount;
  final String title;
  final String content;
  final String representImage;
  final List<String> images;
  final String writer;
  final String createdAt;
  final String updatedAt;
  final String? userImage;

  const FeedResponse({
    required this.id,
    required this.userId,
    required this.likeCount,
    required this.title,
    required this.content,
    required this.representImage,
    required this.images,
    required this.writer,
    required this.createdAt,
    required this.updatedAt,
    this.userImage,
  });

  factory FeedResponse.fromJson(Map<String, dynamic> json) => FeedResponse(
        id: json['feed_id'],
        userId: json['user_id'],
        likeCount: json['like_count'],
        title: json['title'],
        content: json['content'],
        representImage: json['represent_image'],
        images: [for (var image in json['images']) image],
        writer: json['user_nickname'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        userImage: json['user_image'],
      );
}

class PopularFeed {
  final String title;
  final List<String> images;

  PopularFeed({
    required this.title,
    required this.images,
  });

  factory PopularFeed.fromJson(Map<String, dynamic> json) {
    var feeds = [
      for (var feed in json['feeds'].toList()) FeedResponse.fromJson(feed)
    ];

    return PopularFeed(
      title: json['title'],
      images: [for (var feed in feeds) feed.representImage],
    );
  }
}
