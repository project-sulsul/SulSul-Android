import 'package:sul_sul/utils/api/api_client.dart';

class UserRepository {
  final ApiServerConnector apiClient;

  UserRepository({required this.apiClient});

  Future<String> getRandomNickname() async {
    final response = await apiClient.get('/v1/users/nickname');
    final body = response.data as Map<String, dynamic>;
    return body['nickname'];
  }
}
