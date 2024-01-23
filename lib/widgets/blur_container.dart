import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class BlurContainer extends StatelessWidget {
  final Widget child;
  final double padding;

  const BlurContainer({super.key, required this.child, this.padding = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Dark.black,
            spreadRadius: 20,
            blurRadius: 15,
          ),
        ],
      ),
      child: child,
    );
  }
}
