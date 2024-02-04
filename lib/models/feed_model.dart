class FeedsResponse {
  final String subtype;
  final int feedId;
  final String title;
  final String image;
  final double score;
  final String writer;
  final List<String> foods;
  final List<String>? alcohols;

  FeedsResponse({
    required this.subtype,
    required this.feedId,
    required this.title,
    required this.image,
    required this.score,
    required this.writer,
    required this.foods,
    this.alcohols,
  });

  factory FeedsResponse.fromJson(Map<String, dynamic> json) {
    return FeedsResponse(
      subtype: json['subtype'],
      feedId: json['feed_id'],
      title: json['title'],
      image: json['represent_image'],
      score: json['score'],
      writer: json['writer_nickname'],
      foods: [for (var food in json['foods'] ?? []) food],
      alcohols: json['alcohols'] != null
          ? [for (var alcohol in json['alcohols']) alcohol]
          : null,
    );
  }
}
