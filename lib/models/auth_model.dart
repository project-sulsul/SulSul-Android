import 'package:sul_sul/utils/auth/secrets.dart';

class GoogleSignInRequest {
  final String idToken;
  final String googleClientId = googleCloudPlatformClientId;

  GoogleSignInRequest({required this.idToken});

  Map<String, dynamic> toJson() => {
        'google_client_id': googleClientId,
        'id_token': idToken,
      };
}

class KakaoSignInRequest {
  final String accessToken;

  KakaoSignInRequest({required this.accessToken});

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
      };
}

class SignInResponse {
  final String jwt;
  final int httpStatusCode;

  SignInResponse({required this.jwt, required this.httpStatusCode});

  factory SignInResponse.fromJson(
          Map<String, dynamic> json, int? httpStatusCode) =>
      SignInResponse(
        jwt: json['access_token'],
        httpStatusCode: httpStatusCode ?? 0,
      );
}
