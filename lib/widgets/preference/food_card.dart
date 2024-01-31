import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

class FoodCard extends StatelessWidget {
  final String subtype;
  final String name;
  final String search;
  final int id;
  final bool isSelected;
  final FoodCardSize size;
  final void Function(int) onTap;

  const FoodCard({
    super.key,
    required this.subtype,
    required this.name,
    required this.id,
    required this.isSelected,
    this.size = FoodCardSize.S,
    this.search = '',
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 12,
          right: 14,
        ),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: isSelected ? Dark.gray100 : null,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EasyRichText(
              name,
              defaultStyle: TextStyle(
                fontWeight:
                    size == FoodCardSize.L ? FontWeight.bold : FontWeight.w500,
                fontSize: size == FoodCardSize.L ? 18 : 16,
              ),
              patternList: [
                EasyRichTextPattern(
                  targetString: search,
                  style: const TextStyle(
                    color: Main.main,
                  ),
                ),
              ],
            ),
            if (isSelected)
              const Icon(
                CustomIcons.check,
                color: Dark.green500,
                size: 10,
              ),
          ],
        ),
      ),
      onTap: () => onTap(id),
    );
  }
}
