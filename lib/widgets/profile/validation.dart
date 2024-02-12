import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

class Validation extends StatefulWidget {
  final String target;
  final String text;
  final bool isValid;

  const Validation({
    super.key,
    required this.target,
    required this.text,
    required this.isValid,
  });

  @override
  State<Validation> createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  @override
  Widget build(BuildContext context) {
    Color color = widget.target.isEmpty
        ? Dark.gray700
        : widget.isValid
            ? Dark.green500
            : Dark.red500;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          widget.target.isEmpty || widget.isValid
              ? Icon(
                  CustomIcons.check,
                  color: color,
                  size: 10,
                )
              : Icon(
                  CustomIcons.cancle,
                  color: color,
                  size: 10,
                ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.text,
              style: TextStyle(
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
