import 'dart:developer';

import 'package:sul_sul/models/feed/popular_feed_model.dart';
import 'package:sul_sul/utils/api/api_client.dart';

class PopularFeedRepository {
  final ApiServerConnector apiClient;

  PopularFeedRepository({required this.apiClient});

  Future<List<PopularFeedResponse>> getPopularFeedList({
    bool orderByPopular = true,
  }) async {
    try {
      var response = await apiClient.get(
        '/feeds/popular',
        queryParameters: {"order_by_popular": orderByPopular},
      );
      var data = response.data['feeds'].toList();

      return [for (var feed in data) PopularFeedResponse.fromJson(feed)];
    } catch (error) {
      log('[${orderByPopular ? '좋아요 많은 조합' : '색다른 조합'}] 피드 목록 조회 실패 :: $error');
    }
    return [];
  }
}
