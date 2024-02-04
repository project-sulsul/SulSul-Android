import 'dart:developer';

import 'package:sul_sul/utils/api/api_client.dart';
import 'package:sul_sul/models/feed_model.dart';

class FeedRepository {
  final ApiServerConnector apiClient;

  FeedRepository({required this.apiClient});

  Future<List<FeedsResponse>?> getFeedListByAlcohol() async {
    try {
      var response = await apiClient.get('/feeds/by-alcohols');
      var data = response.data['feeds'].toList();

      return [for (var feed in data) FeedsResponse.fromJson(feed)];
    } catch (error) {
      log('피드 목록 조회 실패 :: $error');
    }
    return null;
  }
}
