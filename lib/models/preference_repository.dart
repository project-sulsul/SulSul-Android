import 'dart:developer';

import 'package:sul_sul/utils/api/api_client.dart';
import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/utils/api/uris.dart';

import 'package:sul_sul/utils/auth/id_storage.dart';

class PreferenceRepository {
  final ApiServerConnector apiClient;

  PreferenceRepository({required this.apiClient});

  Future<List<PreferenceResponse>?> getPreferenceList(String type) async {
    try {
      var response =
          await apiClient.get(getPairingsUri, queryParameters: {"type": type});
      // ignore: avoid_dynamic_calls
      var data = response.data['pairings'].toList();

      List<PreferenceResponse> list = [];
      for (var pair in data) {
        var result = PreferenceResponse.fromJson(pair);
        list.add(result);
      }

      return list;
    } catch (error) {
      log('$type 목록 불러오기 실패:: $error');
    }
    return null;
  }

  Future<void> postPairings(PreferenceRequest requestBody) async {
    try {
      await apiClient.post(postPairingsUri, data: requestBody.toJson());
      return;
    } catch (error) {
      log('${requestBody.type} 등록 요청 실패:: $error');
    }
  }

  Future<void> updateUserPreference(Map<String, List<Object>?> data) async {
    try {
      var response =
          await apiClient.put('/users/$userId/preference', data: data);
      print(response);
      // TODO: 유저 정보 저장
    } catch (error) {
      log('[$userId] 유저 취향 변경 실패 :: $error');
    }
  }
}
