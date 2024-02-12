import 'package:sul_sul/utils/constants/main.dart';

class UserResponse {
  final int id;
  final String email;
  final String nickname;
  final String image;
  final String status;
  final UserPreference preference;

  const UserResponse({
    required this.id,
    required this.email,
    required this.nickname,
    required this.image,
    required this.status,
    required this.preference,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    var preference = UserPreference.fromJson(json['preference']);

    return UserResponse(
      id: json["id"],
      email: json["uid"],
      nickname: json["nickname"],
      // TODO: 기본 이미지 변경
      image: json["image"] ?? profileImage,
      status: json["status"],
      preference: preference,
    );
  }
}

class UserPreference {
  final List<int> foods;
  final List<int> alcohols;

  UserPreference({required this.foods, required this.alcohols});

  factory UserPreference.fromJson(Map<String, dynamic> json) => UserPreference(
        foods: [for (var food in json["foods"].toList()) food],
        alcohols: [for (var alcohol in json["alcohols"].toList()) alcohol],
      );
}
