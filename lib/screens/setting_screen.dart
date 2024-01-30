import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/blur_container.dart';
import 'package:sul_sul/widgets/button.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  Widget _listTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Dark.gray500,
        ),
      ),
    );
  }

  Widget _listItem({
    required String name,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Dark.gray050,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Dark.gray900,
              ),
            ),
            const Icon(
              CustomIcons.arrow_forward,
              color: Dark.gray400,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopActionBar(
        title: '설정',
        extend: true,
        type: ActionBarType.back,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _listTitle('취향 관리'),
                _listItem(
                  name: '술 설정',
                  onTap: () {},
                ),
                _listItem(
                  name: '안주 설정',
                  onTap: () {},
                ),
                _listTitle('앱 설정'),
                // TODO: 알림 버튼
                _listItem(
                  name: '피드백',
                  onTap: () {},
                ),
                _listItem(
                  name: '이용약관',
                  onTap: () {},
                ),
                _listItem(
                  name: '개인정보 처리방침',
                  onTap: () {},
                ),
                _listItem(
                  name: '회원탈퇴',
                  onTap: () {},
                ),
              ],
            ),
          ),
          BlurContainer(
            padding: 20,
            child: Button(
              title: '로그아웃',
              onPressed: () {},
              color: Dark.red050,
              size: ButtonSize.large,
              type: ButtonType.plane,
            ),
          )
        ],
      ),
    );
  }
}
