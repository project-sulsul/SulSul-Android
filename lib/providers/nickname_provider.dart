import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:sul_sul/utils/api/api_client.dart';
import 'package:sul_sul/models/user_repository.dart';

class NicknameProvider with ChangeNotifier {
  String _nickname = '';
  String get nickname => _nickname;
  final UserRepository _userRepository =
      UserRepository(apiClient: sulsulServer);

  Future<void> getRandomNickname() async {
    try {
      _nickname = await _userRepository.getRandomNickname();
      notifyListeners();
    } catch (error) {
      log("랜덤 닉네임 호출 실패 :: $error");
    }
  }
}
