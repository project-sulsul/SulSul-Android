import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/button.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopActionBar(
        action: ActionType.setting,
      ),
      body: Center(
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
            Button(
              title: '함께 먹는 안주',
              onPressed: () => Navigator.pushNamed(context, '/preference-food'),
            ),
          ],
        ),
      ),
    );
  }
}
