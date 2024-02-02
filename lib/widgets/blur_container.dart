import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class BlurContainer extends StatelessWidget {
  final Widget child;
  final bool scroll;
  final double padding;

  const BlurContainer({
    super.key,
    required this.child,
    this.scroll = false,
    this.padding = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 24,
        left: padding,
        right: padding,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Dark.black,
            spreadRadius: scroll ? 20 : 16,
            blurRadius: scroll ? 16 : 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
