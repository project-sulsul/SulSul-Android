import 'package:flutter/material.dart';

import 'package:sul_sul/models/user_model.dart';

class UserProvider with ChangeNotifier {
  int? _id;
  String? _uid;
  String? _nickname;
  String? _status;
  // 임시 기본 프로필 사진
  String _image =
      'https://i.pinimg.com/736x/2f/55/97/2f559707c3b04a1964b37856f00ad608.jpg';
  UserPreference _preference =
      UserPreference.fromJson({"foods": [], "alcohols": []});

  int? get id => _id;
  String? get uid => _uid;
  String? get nickname => _nickname;
  String? get status => _status;
  String get image => _image;
  UserPreference get preference => _preference;

  void setUser(UserResponse user) {
    _id = user.id;
    _uid = user.email;
    _nickname = user.nickname;
    _image = user.image;
    _preference = user.preference;
    _status = user.status;
    notifyListeners();
  }
}
