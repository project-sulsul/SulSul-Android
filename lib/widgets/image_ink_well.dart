import 'package:flutter/material.dart';

class ImageInkWell extends StatelessWidget {
  final String iconPath;
  final String text;
  final Color color;
  final Function() onTap;
  final EdgeInsetsGeometry padding;

  const ImageInkWell({
    super.key,
    required this.iconPath,
    required this.onTap,
    this.padding = const EdgeInsets.all(5.0),
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Container(
            width: 280,
            height: 42,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
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
                      padding: const EdgeInsets.only(left: 15),
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
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )));
  }
}
