import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:sul_sul/theme/colors.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? target;

  const HomeTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.target,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EasyRichText(
          title,
          patternList: [
            if (target != null)
              EasyRichTextPattern(
                targetString: target,
                style: const TextStyle(
                  color: Main.main,
                ),
              ),
          ],
          defaultStyle: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle ?? '',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Dark.gray500,
            ),
          )
      ],
    );
  }
}
