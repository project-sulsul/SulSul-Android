import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/open_bottom_sheet.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/widgets/avatar.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/sul_bottom_sheet.dart';

class Profile extends StatelessWidget {
  final String image;

  const Profile({super.key, required this.image});

  Widget _iconButton({
    required IconData icon,
    required String text,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Dark.gray050,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(
              icon,
              color: Dark.gray900,
              size: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomSheet() {
    return SulBottomSheet(
      handleBar: false,
      type: BottomsheetType.floating,
      list: [
        _iconButton(
          icon: CustomIcons.camera_outlined,
          text: '사진 촬영',
          onTap: () {},
        ),
        _iconButton(
          icon: CustomIcons.picture_outlined,
          text: '앨범에서 사진 선택',
          onTap: () {},
        ),
        _iconButton(
          icon: CustomIcons.profile_outlined,
          text: '기본 이미지 사용',
          onTap: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 16,
        bottom: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Avatar(
            image: image,
            borderRadius: 40,
            width: 80,
            height: 80,
          ),
          const SizedBox(height: 16),
          Button(
            title: '사진 변경',
            onPressed: () => openBottomSheet(context, _bottomSheet()),
            round: true,
            size: ButtonSize.mini,
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
        ],
      ),
    );
  }
}
