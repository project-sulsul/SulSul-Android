import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class CategoryChip extends StatelessWidget {
  final String name;
  final Color color;
  final Color bgColor;

  const CategoryChip({
    super.key,
    required this.name,
    this.color = Main.main,
    this.bgColor = Dark.yellow050,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bgColor,
      ),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
