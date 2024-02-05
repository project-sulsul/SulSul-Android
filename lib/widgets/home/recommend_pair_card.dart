import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/widgets/category_chip.dart';
import 'package:sul_sul/widgets/sul_chip.dart';

class RecommendPairCard extends StatelessWidget {
  final String title;
  final String writer;
  final String image;
  final String food;
  final String? alcohol;
  final double? score;
  final void Function()? onTap;

  const RecommendPairCard({
    super.key,
    required this.title,
    required this.writer,
    required this.image,
    required this.food,
    this.alcohol,
    this.score,
    this.onTap,
  });

  Widget _pairngs() {
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                CustomIcons.clap_filled,
                size: 16,
                color: Main.main,
              ),
            ),
            Text(
              '$score',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 277,
        height: 323,
        margin: const EdgeInsets.only(right: 16),
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
                  height: 195,
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
                      label: writer,
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _pairngs(),
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
