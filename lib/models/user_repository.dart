import 'dart:developer';

import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/auth/id_storage.dart';

class UserRepository {
  final ApiServerConnector apiClient;

  UserRepository({required this.apiClient});

  Future<String> getRandomNickname() async {
    final response = await apiClient.get('/users/nickname');
    final body = response.data as Map<String, dynamic>;
    return body['nickname'];
  }

  Future<void> updateNickname(String nickname) async {
    try {
      await apiClient
          .put('/users/$userId/nickname', data: {'nickname': nickname});
    } catch (error) {
      log('[$userId] 닉네임 업데이트 실패 (nickname: $nickname) :: $error');
    }
  }
}
