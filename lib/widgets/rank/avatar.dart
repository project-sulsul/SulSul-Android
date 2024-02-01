import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class Avatar extends StatelessWidget {
  final String image;
  final double width;
  final double height;

  const Avatar({
    super.key,
    required this.image,
    this.width = 60,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.7),
        color: Dark.gray100,
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        image,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
