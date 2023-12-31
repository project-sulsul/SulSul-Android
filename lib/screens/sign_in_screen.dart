import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/providers/count.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/widgets/header.dart';

import 'package:sul_sul/widgets/image_ink_well.dart';

import 'package:sul_sul/models/auth_repository.dart';

import 'package:sul_sul/utils/api/http_code.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void handleSignInResult(int httpStatusCode) {
      if (httpStatusCode == HttpStatusCode.created) {
        Navigator.pushReplacementNamed(
            context, '/preference'); // TODO : 회원가입 시 취향 선택 화면으로 이동
      } else if (httpStatusCode == HttpStatusCode.ok) {
        Navigator.pushReplacementNamed(context, '/home'); // TODO : 메인 화면으로 이동
      } else {
        Navigator.pushReplacementNamed(
            context, '/sign-in'); // TODO : 로그인 화면으로 이동
      }
    }

    final authRepository = AuthRepository(apiClient: sulsulServer);
    return Scaffold(
      appBar: const Header(title: '술이 술술'),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => Counter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageInkWell(
                  text: '카카오로 계속하기',
                  color: Colors.yellow,
                  iconPath: 'assets/images/kakao_icon.png',
                  onTap: () async {
                    final response = await authRepository.signInByKakao();
                    handleSignInResult(response!.httpStatusCode);
                  }),
              ImageInkWell(
                  text: 'Google로 계속하기',
                  color: Colors.white,
                  iconPath: 'assets/images/google_icon.png',
                  onTap: () async {
                    final response = await authRepository.signInByGoogle();
                    handleSignInResult(response!.httpStatusCode);
                  }),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/update-nickname');
                },
                child: const Text('닉네임 변경'),
              ),
            ],
          ),
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
