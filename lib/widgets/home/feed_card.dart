import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/widgets/category_chip.dart';
import 'package:sul_sul/widgets/sul_chip.dart';

class FeedCard extends StatelessWidget {
  final String title;
  final String writer;
  final String image;
  final String food;
  final String? alcohol;
  final String? content;
  final double? score;
  final void Function()? onTap;

  const FeedCard({
    super.key,
    required this.title,
    required this.writer,
    required this.image,
    required this.food,
    this.alcohol,
    this.content,
    this.score,
    this.onTap,
  });

  Widget _pairngs(bool existContent) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (alcohol != null) CategoryChip(name: '$alcohol'),
            if (alcohol != null)
              const Text(
                ' & ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Dark.white,
                ),
              ),
            CategoryChip(name: food),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                CustomIcons.clap_filled,
                size: existContent ? 24 : 16,
                color: Main.main,
              ),
            ),
            Text(
              '$score',
              style: TextStyle(
                fontSize: existContent ? 18 : 12,
                fontWeight: existContent ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool existContent = content != null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: existContent ? double.infinity : 277,
        height: existContent ? 416 : 323,
        margin: existContent
            ? const EdgeInsets.only(bottom: 16)
            : const EdgeInsets.only(right: 16),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Dark.gray100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  image,
                  width: double.infinity,
                  height: existContent ? 264 : 195,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: SulChip(
                      label: '@$writer',
                      size: ChipSize.large,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _pairngs(existContent),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (existContent)
                      Expanded(
                        child: Text(
                          content ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Dark.gray800,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
