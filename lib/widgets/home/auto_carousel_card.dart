import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/button.dart';

class AutoCarouselCard extends StatelessWidget {
  final String name;
  final String alcohol;
  final List<String> imageList;

  const AutoCarouselCard({
    super.key,
    required this.name,
    required this.alcohol,
    required this.imageList,
  });

  void _onPressed() {
    // TODO: 피드 작성 화면으로 이동
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TODO: auto carousel로 변경
        Image.network(
          'https://src.hidoc.co.kr/image/lib/2022/3/3/1646297561944_0.jpg',
          width: double.infinity,
          height: 323,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 323,
          decoration: BoxDecoration(
            color: const Color(0xFF202020).withOpacity(0.8),
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 323,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$name님이\n$alcohol와 함께 즐겼던\n특별한 순간을 공유해주실래요?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Button(
                title: '첫 게시물 작성해보기',
                onPressed: _onPressed,
                type: ButtonType.active,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
