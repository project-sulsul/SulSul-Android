import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class Button extends StatelessWidget {
  final String title;
  final void Function() onPressed;

  final String? type;
  final String? size;
  final bool? round;
  final bool? leftIcon;
  final bool? rightIcon;
  final void Function()? onIconPressed;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.type,
    this.size,
    this.round,
    this.leftIcon,
    this.rightIcon,
    this.onIconPressed,
  });

  ({double width, double height}) _getButtonSize() {
    switch (size) {
      case 'mini':
        return (width: 76.0, height: 32.0);
      case 'S':
        return (width: 80.0, height: 40.0);
      case 'L':
        return (width: 353.0, height: 52.0);
      default:
        return (width: 156.0, height: 52.0);
    }
  }

  BorderRadius _getBorderRadius(bool round) {
    double radius = 16;

    if (round) {
      return BorderRadius.all(Radius.circular(radius));
    }

    switch (size) {
      case 'mini':
        radius = 16;
        break;
      case 'S':
        radius = 8;
        break;
      case 'L':
        radius = 12;
        break;
      default:
        radius = 10;
        break;
    }

    return BorderRadius.all(Radius.circular(radius));
  }

  BorderSide _getBorderStyle() {
    if (type == 'Gost') {
      return const BorderSide(color: Dark.gray400, width: 1);
    }

    return const BorderSide(color: Colors.transparent, width: 0);
  }

  Color _getBgColor() {
    switch (type) {
      case 'Plane':
      case 'Gost':
        return Colors.transparent;
      case 'Active':
        return Main.main;
      default:
        return Dark.gray200;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case 'Plane':
      case 'Gost':
        return Dark.gray400;
      case 'Active':
        return Dark.gray200;
      default:
        return Dark.gray700;
    }
  }

  // TODO: icon 변경
  // FIXME: icon & text 간격 설정
  Widget _deleteIconButton() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      color: _getTextColor(),
      onPressed: onIconPressed,
      icon: const Icon(Icons.cancel_outlined),
      iconSize: 20,
      visualDensity: const VisualDensity(horizontal: -4),
    );
  }

  Widget _getButtonChild(String text, bool leftIcon, bool rightIcon) {
    if (leftIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _deleteIconButton(),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      );
    }

    if (rightIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text, style: const TextStyle(fontSize: 16)),
          _deleteIconButton(),
        ],
      );
    }

    return Text(text,
        textAlign: TextAlign.center, style: const TextStyle(fontSize: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _getButtonSize().width,
      height: _getButtonSize().height,
      margin: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: type == 'Disable' ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: _getBorderStyle(),
          backgroundColor: _getBgColor(),
          foregroundColor: _getTextColor(),
          disabledForegroundColor: Dark.gray300,
          disabledBackgroundColor: Dark.gray100,
          shape: RoundedRectangleBorder(
            borderRadius: _getBorderRadius(round ?? false),
          ),
        ),
        child: _getButtonChild(title, leftIcon ?? false, rightIcon ?? false),
      ),
    );
  }
}
