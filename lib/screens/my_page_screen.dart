import 'package:flutter/material.dart';
import 'package:sul_sul/widgets/button.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Button(
            title: '닉네임 변경',
            onPressed: () => Navigator.pushNamed(context, '/update-nickname'),
          ),
          Button(
            title: '선호하는 술',
            onPressed: () =>
                Navigator.pushNamed(context, '/preference-alcohol'),
          ),
        ],
      ),
    );
  }
}
