
import 'package:flutter/cupertino.dart';
import 'package:sul_sul/models/user_repository.dart';
import 'package:sul_sul/utils/api/api_client.dart';

class NicknameProvider with ChangeNotifier {
  String _nickname = '';
  String get nickname => _nickname;
  final UserRepository _userRepository =
      UserRepository(apiClient: sulsulServer);

  void getRandomNickname() async {
    _nickname = await _userRepository.getRandomNickname();
    notifyListeners();
  }
}
