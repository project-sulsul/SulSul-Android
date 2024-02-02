import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

class SulChip extends StatelessWidget {
  final String label;
  final bool icon;
  final ChipSize size;

  const SulChip({
    super.key,
    required this.label,
    this.icon = false,
    this.size = ChipSize.small,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: EdgeInsets.zero,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon)
            const Icon(
              CustomIcons.picture_outlined,
              color: Dark.gray700,
            ),
          Text(
            label,
            style: TextStyle(
              fontSize: size == ChipSize.large ? 12 : 10,
              fontWeight: FontWeight.w400,
              color: Dark.gray900,
            ),
          ),
        ],
      ),
      visualDensity: const VisualDensity(
        horizontal: -4,
        vertical: -4,
      ),
      backgroundColor: Dark.gray200,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
