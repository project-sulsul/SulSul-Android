import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

Future<void> loginByKakao() async {
  try {
    OAuthToken kakaoToken = await isKakaoTalkInstalled()
        ? await _loginWithKakaoTalk()
        : await _loginWithKakaoAccount();
    log('Kakao login success - AccessToken: ${kakaoToken.accessToken}');
    // TODO : accessToken을 서버로 보내서 로그인 처리를 해야함
  } catch (error) {
    if (_isUserCancelError(error)) {
      log('User cancelled login');
      return;
    }
    log('Kakao login failed - $error');
  }
}

Future<void> logoutByKakao() async {
  try {
    await UserApi.instance.logout();
    log('Kakao logout success');
  } catch (error) {
    log('Kakao logout failed - $error');
  }
}

Future<OAuthToken> _loginWithKakaoTalk() async {
  return await UserApi.instance.loginWithKakaoTalk();
}

Future<OAuthToken> _loginWithKakaoAccount() async {
  return await UserApi.instance.loginWithKakaoAccount();
}

bool _isUserCancelError(dynamic error) {
  return error is PlatformException && error.code == 'CANCELED';
}
