import 'dart:developer';

import 'package:sul_sul/utils/api/api_client.dart';
import 'package:sul_sul/models/feed/recommend_feed_model.dart';

class RecommendFeedRepository {
  final ApiServerConnector apiClient;

  RecommendFeedRepository({required this.apiClient});

  Future<List<RecommendFeedsResponse>?> getFeedListByAlcohol() async {
    try {
      var response = await apiClient.get('/feeds/by-alcohols');
      var data = response.data['feeds'].toList();

      return [for (var feed in data) RecommendFeedsResponse.fromJson(feed)];
    } catch (error) {
      log('[술 카테고리] 피드 목록 조회 실패 :: $error');
    }
    return null;
  }

  Future<List<RecommendFeedsResponse>?> getFeedListByPreference() async {
    try {
      var response = await apiClient.get('/feeds/by-preferences');
      var data = response.data['feeds'].toList();

      print('hidhfisdhfklsdjf $data');
      return [for (var feed in data) RecommendFeedsResponse.fromJson(feed)];
    } catch (error) {
      log('[취향 등록] 피드 목록 조회 실패 :: $error');
    }
    return null;
  }
}
