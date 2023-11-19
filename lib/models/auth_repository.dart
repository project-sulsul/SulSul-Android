import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sul_sul/models/auth_model.dart';
import 'package:sul_sul/utils/api/api_client.dart';
import 'package:sul_sul/utils/api/uris.dart';

import 'package:sul_sul/utils/auth/jwt_storage.dart';

class AuthRepository {
  final ApiServerConnector apiClient;

  AuthRepository({required this.apiClient});

  Future<SignInResponse> _postSignInByGoogle(String idToken) async {
    final request = GoogleSignInRequest(idToken: idToken).toJson();
    final response = await apiClient.post(postSignInGoogleUri, data: request);
    log('술술 구글 소셜 로그인 성공 JWT : ${response.data}');
    return SignInResponse.fromJson(response.data, response.statusCode);
  }

  Future<SignInResponse?> signInByGoogle() async {
    final googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
      if (googleAccount == null) {
        log('Google login was cancelled by the user');
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      String idToken = googleAuth.idToken ?? '';

      final response = await _postSignInByGoogle(idToken);
      jwtStorage.set(response.jwt);

      return response;
    } catch (error) {
      log('Google login failed - $error');
      return null;
    }
  }

  Future<SignInResponse> _postSignInByKakao(String accessToken) async {
    final response = await apiClient.post(postSignInKakaoUri, data: {
      'access_token': accessToken,
    });
    log('술술 카카오 소셜 로그인 성공 JWT : ${response.data}');
    return SignInResponse.fromJson(response.data, response.statusCode);
  }

  Future<SignInResponse?> signInByKakao() async {
    try {
      OAuthToken kakaoToken = await isKakaoTalkInstalled()
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      final response = await _postSignInByKakao(kakaoToken.accessToken);

      jwtStorage.set(response.jwt);

      return response;
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELED') {
        log('User cancelled login');
        return null;
      }
      log('Kakao login failed - $error');
      return null;
    }
  }

  void signOut() {
    jwtStorage.expire();
  }
}
