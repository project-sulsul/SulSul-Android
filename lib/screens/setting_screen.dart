import 'package:flutter/material.dart';

import 'package:sul_sul/models/user_repository.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/constants/messages.dart';
import 'package:sul_sul/utils/open_bottom_sheet.dart';
import 'package:sul_sul/utils/route.dart';
import 'package:sul_sul/utils/auth/id_storage.dart';
import 'package:sul_sul/utils/auth/jwt_storage.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/screens/preference/alcohol_screen.dart';
import 'package:sul_sul/screens/preference/food_screen.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/blur_container.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/modal.dart';
import 'package:sul_sul/widgets/sul_bottom_sheet.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  UserRepository userRepository = UserRepository(apiClient: sulsulServer);

  void _deleteUser() async {
    // TODO: 회원 탈퇴
    userRepository.deleteUser().then((res) {
      jwtStorage.expire();
      print('delete $userId');
    });
  }

  void _onSignOut(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((context) {
        return Modal(
          title: '로그아웃 하시겠어요?',
          type: DialogType.confirm,
          actionButtonText: '로그아웃',
          actionButtonTextColor: Dark.white,
          actionButtonColor: Dark.red500,
          onPressedActionButton: () => jwtStorage
              .expire()
              .then((res) => Navigator.pushNamed(context, '/')),
        );
      }),
    );
  }

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

  Widget _bottomSheet() {
    return SulBottomSheet(
      title: '탈퇴하시겠어요?',
      button: true,
      content: signOutMessage,
      firstButtonText: '취소',
      secondButtonText: '회원탈퇴',
      secondButtonTextColor: Dark.white,
      secondButtonBgColor: Dark.red500,
      onPressedsecondButton: _deleteUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    void navigate(Widget screen) {
      Navigator.of(context).push(createRoute(screen));
    }

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
                  onTap: () => navigate(const PreferenceAlcoholScreen()),
                ),
                _listItem(
                  name: '안주 설정',
                  onTap: () => navigate(const PreferenceFoodScreen()),
                ),
                _listTitle('앱 설정'),
                // TODO: 알림 버튼
                _listItem(
                  name: '피드백',
                  // TODO: play store 이동
                  onTap: () {},
                ),
                _listItem(
                  name: '이용약관',
                  // TODO: 노션 이동
                  onTap: () {},
                ),
                _listItem(
                  name: '개인정보 처리방침',
                  // TODO: 노션 이동
                  onTap: () {},
                ),
                _listItem(
                  name: '회원탈퇴',
                  onTap: () => openBottomSheet(context, _bottomSheet()),
                ),
              ],
            ),
          ),
          BlurContainer(
            padding: 20,
            child: Button(
              title: '로그아웃',
              onPressed: () => _onSignOut(context),
              textColor: Dark.red500,
              size: ButtonSize.large,
              type: ButtonType.plane,
            ),
          )
        ],
      ),
    );
  }
}
