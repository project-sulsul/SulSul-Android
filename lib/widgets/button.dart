import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/utils/constants.dart';

enum ButtonStyle {
  mini(width: 76.0, height: 32.0, radius: 16.0),
  small(width: 80.0, height: 40.0, radius: 8.0),
  medium(width: 130.0, height: 52.0, radius: 10.0),
  large(width: double.infinity, height: 52.0, radius: 12.0);

  final double width;
  final double height;
  final double radius;

  const ButtonStyle({
    required this.width,
    required this.height,
    required this.radius,
  });
}

class Button extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  final ButtonSize size;
  final bool round;
  final bool leftIcon;
  final bool rightIcon;
  final Color? color;
  final ButtonType? type;
  final void Function()? onIconPressed;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.size = ButtonSize.fit,
    this.round = false,
    this.leftIcon = false,
    this.rightIcon = false,
    this.color,
    this.type,
    this.onIconPressed,
  });

  ({double width, double height}) _getButtonSize() {
    switch (size) {
      case ButtonSize.mini:
        return (width: ButtonStyle.mini.width, height: ButtonStyle.mini.height);
      case ButtonSize.small:
        return (
          width: ButtonStyle.small.width,
          height: ButtonStyle.small.height
        );
      case ButtonSize.large:
        return (
          width: ButtonStyle.large.width,
          height: ButtonStyle.large.height
        );
      default:
        return (
          width: ButtonStyle.medium.width,
          height: ButtonStyle.medium.height
        );
    }
  }

  BorderRadius _getBorderRadius(bool round) {
    var radius = 16.0;

    if (round) {
      return BorderRadius.all(Radius.circular(radius));
    }

    switch (size) {
      case ButtonSize.mini:
        radius = ButtonStyle.mini.radius;
        break;
      case ButtonSize.small:
        radius = ButtonStyle.small.radius;
        break;
      case ButtonSize.large:
        radius = ButtonStyle.large.radius;
        break;
      default:
        radius = ButtonStyle.medium.radius;
        break;
    }

    return BorderRadius.all(Radius.circular(radius));
  }

  BorderSide _getBorderStyle() {
    if (type == ButtonType.gost) {
      return const BorderSide(color: Dark.gray400, width: 1);
    }

    return const BorderSide(color: Colors.transparent, width: 0);
  }

  Color _getBgColor() {
    switch (type) {
      case ButtonType.plane:
      case ButtonType.gost:
        return Colors.transparent;
      case ButtonType.active:
        return Main.main;
      default:
        return Dark.gray200;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case ButtonType.plane:
      case ButtonType.gost:
        return Dark.gray400;
      case ButtonType.active:
        return Dark.gray200;
      default:
        return Dark.gray700;
    }
  }

  // TODO: icon 변경
  // FIXME: icon & text 간격 설정
  Widget _iconButton() {
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
          _iconButton(),
          Text(text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ],
      );
    }

    if (rightIcon) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          _iconButton(),
        ],
      );
    }

    return Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (size == ButtonSize.fit) {
      return SizedBox(
        child: SizedBox(
          height: _getButtonSize().height,
          child: OutlinedButton(
            onPressed: type == ButtonType.disable ? null : onPressed,
            style: OutlinedButton.styleFrom(
              side: _getBorderStyle(),
              backgroundColor: _getBgColor(),
              foregroundColor: color ?? _getTextColor(),
              disabledForegroundColor: Dark.gray300,
              disabledBackgroundColor: Dark.gray100,
              shape: RoundedRectangleBorder(
                borderRadius: _getBorderRadius(round),
              ),
            ),
            child: _getButtonChild(title, leftIcon, rightIcon),
          ),
        ),
      );
    }

    return Container(
      width: _getButtonSize().width,
      height: _getButtonSize().height,
      margin: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: type == ButtonType.disable ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: _getBorderStyle(),
          backgroundColor: _getBgColor(),
          foregroundColor: color ?? _getTextColor(),
          disabledForegroundColor: Dark.gray300,
          disabledBackgroundColor: Dark.gray100,
          shape: RoundedRectangleBorder(
            borderRadius: _getBorderRadius(round),
          ),
        ),
        child: _getButtonChild(title, leftIcon, rightIcon),
      ),
    );
  }
}
