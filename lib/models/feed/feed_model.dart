class FeedResponse {
  final int id;
  final int userId;
  final int likeCount;
  final String title;
  final String content;
  final String image;
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
    required this.image,
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
        image: json['represent_image'],
        writer: json['user_nickname'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        userImage: json['user_image'],
      );
}
