import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/button.dart';

class Modal extends StatelessWidget {
  final String title; // dialog title
  final DialogType type; // alert / confirm type
  final String cancelText; // left button text
  final String confirmText; // right button text
  final bool isVertical; // button sorting
  final Alignment alignment; // position
  final String? subtitle; // content (subtitle)
  final void Function()? onConfirmed; // confirm action

  const Modal({
    super.key,
    required this.title,
    this.type = DialogType.alert,
    this.cancelText = '취소',
    this.confirmText = '확인',
    this.isVertical = false,
    this.alignment = Alignment.center,
    this.subtitle,
    this.onConfirmed,
  });

  Widget? _content(String? content) {
    if (content == null) return null;

    return Text(
      content,
      style: const TextStyle(
        color: Dark.gray900,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    );
  }

  List<Widget> _actionButtons(BuildContext context) {
    if (type == DialogType.confirm) {
      return [
        Button(
          size: isVertical ? ButtonSize.large : ButtonSize.medium,
          title: cancelText,
          onPressed: () => Navigator.of(context).pop(),
        ),
        Button(
          size: isVertical ? ButtonSize.large : ButtonSize.medium,
          title: confirmText,
          type: ButtonType.active,
          onPressed: onConfirmed ?? () {},
        )
      ];
    }

    return [
      Button(
        size: ButtonSize.large,
        title: '확인',
        onPressed: () => Navigator.of(context).pop(),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Dark.gray900,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      titlePadding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: subtitle == null ? 0 : 10,
      ),
      content: _content(subtitle),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      actions: _actionButtons(context),
      actionsPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 14,
      ),
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Dark.gray100,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      alignment: alignment,
    );
  }
}
