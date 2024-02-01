import 'dart:developer';

import 'package:sul_sul/models/rank_model.dart';
import 'package:sul_sul/utils/api/api_client.dart';

class RankRepository {
  final ApiServerConnector apiClient;

  RankRepository({required this.apiClient});

  Future<RankResponse?> getAlcoholRankList() async {
    try {
      var response = await apiClient.get('/ranks/alcohol');
      var result = RankResponse.fromAlcoholJson(response.data);

      return result;
    } catch (error) {
      log('술 랭킹 조회 실패:: $error');
    }
    return null;
  }
}
