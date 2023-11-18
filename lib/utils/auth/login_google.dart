import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<void> loginByGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      log('Google login was cancelled by the user');
      return;
    }
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    log("Google login success - accessToken : ${googleSignInAuthentication.accessToken}");
    // TODO: 서버에 accessToken을 보내어 사용자 인증 처리를 수행해야 함
  } catch (error) {
    log('Google login failed - $error');
  }
}

Future<void> logoutByGoogle() async {
  try {
    await _googleSignIn.disconnect();
  } catch (error) {
    log('Google logout failed - $error');
  }
}
