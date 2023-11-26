import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/auth/id_storage.dart';

class UserRepository {
  final ApiServerConnector apiClient;

  UserRepository({required this.apiClient});

  Future<String> getRandomNickname() async {
    final response = await apiClient.get('/v1/users/nickname');
    final body = response.data as Map<String, dynamic>;
    return body['nickname'];
  }

  Future<void> updateNickname(String nickname) async {
    await apiClient
        .post('/v1/users/$userId/nickname', data: {'nickname': nickname});
  }
}
