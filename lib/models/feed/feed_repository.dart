import 'dart:developer';

import 'package:sul_sul/models/feed/feed_model.dart';
import 'package:sul_sul/utils/api/api_client.dart';

class FeedRepository {
  final ApiServerConnector apiClient;

  FeedRepository({required this.apiClient});

  Future<List<PopularFeed>> getPopularFeedList({
    bool orderByPopular = true,
  }) async {
    try {
      var response = await apiClient.get(
        '/feeds/popular',
        queryParameters: {"order_by_popular": orderByPopular},
      );
      var data = response.data.toList();

      return [for (var feed in data) PopularFeed.fromJson(feed)];
    } catch (error) {
      log('[${orderByPopular ? '좋아요 많은 조합' : '색다른 조합'}] 피드 목록 조회 실패 :: $error');
    }
    return [];
  }
}
