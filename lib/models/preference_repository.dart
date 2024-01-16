import 'dart:developer';

import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/utils/api/api_client.dart';

class PreferenceRepository {
  final ApiServerConnector apiClient;

  PreferenceRepository({required this.apiClient});

  Future<List<PreferenceResponse>?> getPreferenceList(String type) async {
    try {
      final response =
          await apiClient.get('/pairings', queryParameters: {"type": type});
      // ignore: avoid_dynamic_calls
      var data = response.data['pairings'].toList();

      List<PreferenceResponse> list = [];
      for (var alcohol in data) {
        var result = PreferenceResponse.fromJson(alcohol);
        list.add(result);
      }

      return list;
    } catch (error) {
      log('$type 목록 불러오기 실패:: $error');
    }
    return null;
  }
}
