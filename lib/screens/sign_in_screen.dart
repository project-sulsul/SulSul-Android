import 'package:flutter/material.dart';

import 'package:sul_sul/utils/api/api_client.dart';
import 'package:sul_sul/utils/api/http_code.dart';
import 'package:sul_sul/models/auth_repository.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/widgets/button.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/image_ink_well.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void handleSignInResult(int httpStatusCode) {
      if (httpStatusCode == HttpStatusCode.created) {
        Navigator.pushReplacementNamed(
            context, '/update-nickname'); // TODO : 회원가입 시 닉네임 설정 화면으로 이동
      } else if (httpStatusCode == HttpStatusCode.ok) {
        Navigator.pushReplacementNamed(context, '/home'); // TODO : 메인 화면으로 이동
      } else {
        Navigator.pushReplacementNamed(
            context, '/sign-in'); // TODO : 로그인 화면으로 이동
      }
    }

    final authRepository = AuthRepository(apiClient: sulsulServer);
    return Scaffold(
      appBar: const TopActionBar(
        type: ActionBarType.back,
        title: '만나서\n반가워요! :)',
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageInkWell(
                text: '카카오로 시작하기',
                color: Colors.yellow,
                iconPath: 'assets/images/kakao_icon.png',
                onTap: () async {
                  final response = await authRepository.signInByKakao();
                  handleSignInResult(response!.httpStatusCode);
                }),
            ImageInkWell(
                text: 'Google로 시작하기',
                color: Colors.white,
                iconPath: 'assets/images/google_icon.png',
                onTap: () async {
                  final response = await authRepository.signInByGoogle();
                  handleSignInResult(response!.httpStatusCode);
                }),
            Button(
              title: '닉네임 변경',
              onPressed: () {
                Navigator.pushNamed(context, '/update-nickname');
              },
              type: ButtonType.plane,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/home'),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
