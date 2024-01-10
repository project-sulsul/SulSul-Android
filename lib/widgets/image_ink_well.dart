import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class ImageInkWell extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color color;
  final Function() onTap;
  final EdgeInsetsGeometry padding;
  final TextStyle? style;

  const ImageInkWell({
    super.key,
    required this.iconPath,
    required this.onTap,
    this.padding = const EdgeInsets.all(5.0),
    required this.text,
    required this.color,
    this.style = const TextStyle(color: Dark.gray200),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Image.asset(iconPath, width: 24, height: 24),
                    )),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey.withOpacity(0.5),
                      onTap: onTap,
                      child: Center(
                        child: Text(
                          text,
                          style: style,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
