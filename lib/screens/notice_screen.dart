import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/blur_container.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/top_action_bar.dart';

class NoticeScreen extends StatelessWidget {
  final String title;
  final String buttonName;
  final String? subtitle;

  const NoticeScreen({
    super.key,
    required this.title,
    required this.buttonName,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopActionBar(
        extend: true,
        title: title,
        subtitle: subtitle,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Expanded(
              child: Center(
                child: Text('이미지'),
              ),
            ),
            BlurContainer(
              child: Button(
                title: buttonName,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false),
                size: ButtonSize.large,
                type: ButtonType.active,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
