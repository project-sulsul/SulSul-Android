import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/avatar.dart';
import 'package:sul_sul/widgets/button.dart';

class Profile extends StatelessWidget {
  final String image;

  const Profile({super.key, required this.image});

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
            onPressed: () {},
            round: true,
            size: ButtonSize.mini,
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
        ],
      ),
    );
  }
}
