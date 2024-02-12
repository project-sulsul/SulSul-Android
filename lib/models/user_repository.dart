import 'dart:developer';

import 'package:sul_sul/models/user_model.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/auth/id_storage.dart';

class UserRepository {
  final ApiServerConnector apiClient;

  UserRepository({required this.apiClient});

  Future<UserResponse?> getUserDataById() async {
    try {
      final response = await apiClient.get('/users/$userId');
      return UserResponse.fromJson(response.data);
    } catch (error) {
      log('[$userId] 유저 데이터 조회 실패 :: $error');
    }
    return null;
  }

  Future<String> getRandomNickname() async {
    try {
    final response = await apiClient.get('/users/nickname');
    final body = response.data as Map<String, dynamic>;
    return body['nickname'];
    } catch (error) {
      log('랜덤 닉네임 조회 실패 :: $error');
    }

    return '';
  }

  Future<UserResponse?> updateNickname(String nickname) async {
    try {
      var response = await apiClient
          .put('/users/$userId/nickname', data: {'nickname': nickname});
      return UserResponse.fromJson(response.data);
    } catch (error) {
      log('[$userId] 닉네임 업데이트 실패 (nickname: $nickname) :: $error');
    }
    return null;
  }

  Future<void> deleteUser() async {
    try {
      await apiClient.delete('/users/$userId');
    } catch (error) {
      log('[$userId] 회원 탈퇴 실패 :: $error');
    }
  }
}
