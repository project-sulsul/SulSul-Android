import 'package:flutter/material.dart';

import 'package:sul_sul/models/auth_repository.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/utils/api/api_client.dart';
import 'package:sul_sul/utils/api/http_code.dart';

import 'package:sul_sul/widgets/header.dart';
import 'package:sul_sul/widgets/image_ink_well.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void handleSignInResult(int httpStatusCode) {
      if (httpStatusCode == HttpStatusCode.created) {
        Navigator.pushReplacementNamed(context, '/update-nickname');
      } else if (httpStatusCode == HttpStatusCode.ok) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/sign-in');
      }
    }

    final authRepository = AuthRepository(apiClient: sulsulServer);
    return Scaffold(
      appBar: const Header(title: ''),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '만나서\n반가워요! :)',
                    style: TextStyle(
                      color: Dark.gray900,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ImageInkWell(
                      text: '카카오톡으로 시작하기',
                      color: const Color(0xFFFEE500),
                      style: const TextStyle(
                        color: Dark.gray200,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                      iconPath: 'assets/images/kakao_icon.png',
                      onTap: () async {
                        final response = await authRepository.signInByKakao();
                        handleSignInResult(response!.httpStatusCode);
                      }),
                  ImageInkWell(
                    text: 'Google로 시작하기',
                    color: Colors.white,
                    style: const TextStyle(
                      color: Dark.gray200,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                    iconPath: 'assets/images/google_icon.png',
                    onTap: () async {
                      final response = await authRepository.signInByGoogle();
                      handleSignInResult(response!.httpStatusCode);
                    },
                  ),
                ],
              ),
              const Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '가입을 진행할 경우, ',
                        style: TextStyle(
                          color: Dark.gray500,
                        ),
                      ),
                      Text(
                        '서비스 약관',
                        style: TextStyle(
                          color: Dark.gray800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ' 및',
                        style: TextStyle(
                          color: Dark.gray500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '개인정보 처리방침',
                        style: TextStyle(
                          color: Dark.gray800,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '에 동의한 것으로 간주합니다.',
                        style: TextStyle(
                          color: Dark.gray500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
