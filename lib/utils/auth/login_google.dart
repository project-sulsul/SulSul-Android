import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<void> loginByGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    log("accessToken : ${googleSignInAuthentication.accessToken}");
    // TODO : accessToken을 서버로 보내서 로그인 처리를 해야함
    // 구글 액세스토큰은 저장을 굳이 해야하나?
  } catch (error) {
    log(error.toString());
  }
}

Future<void> logoutByGoogle() async {
  await _googleSignIn.signOut();
}
