import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/notice_count.dart';

class SubHeader extends StatelessWidget {
  final String title;
  final int num;
  final int count;
  final int maxNum;

  const SubHeader({
    super.key,
    required this.title,
    required this.num,
    required this.count,
    required this.maxNum,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Q$num.',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Dark.gray900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 30,
                      color: Dark.gray900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$count개 ',
                    style: TextStyle(
                      color: count > 0 ? Main.main : Dark.gray300,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '선택됨',
                    style: TextStyle(
                      color: count > 0 ? Main.main : Dark.gray300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: -3,
          top: 15,
          child: NoticeCount(
            count: maxNum,
          ),
        ),
      ],
    );
  }
}
