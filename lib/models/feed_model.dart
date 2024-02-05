class FeedsResponse {
  final String subtype;
  final int feedId;
  final String title;
  final String image;
  final String foods;
  final double score;
  final String writer;
  final String? alcohols;

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
      subtype: json['subtype'] ?? '',
      feedId: json['feed_id'],
      title: json['title'],
      image: json['represent_image'] ??
          'https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg',
      score: json['score'],
      writer: json['writer_nickname'],
      // NOTICE: 첫 번째 요소만 보여주도록 비즈니스 로직 합의
      foods: json['foods'].toList()[0],
      alcohols: json['alcohols'] != null ? json['alcohols'].toList()[0] : null,
    );
  }
}
