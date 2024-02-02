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
  final Color? textColor;
  final Color? bgColor;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final ButtonType? type;
  final void Function()? onIconPressed;

  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.size = ButtonSize.fit,
    this.round = false,
    this.textColor,
    this.bgColor,
    this.iconColor,
    this.padding,
    this.leftIcon,
    this.rightIcon,
    this.type,
    this.onIconPressed,
  });

  ({double width, double height}) _getButtonSize() {
    switch (size) {
      case ButtonSize.mini:
        return (
          width: ButtonStyle.mini.width,
          height: ButtonStyle.mini.height,
        );
      case ButtonSize.small:
        return (
          width: ButtonStyle.small.width,
          height: ButtonStyle.small.height,
        );
      case ButtonSize.large:
        return (
          width: ButtonStyle.large.width,
          height: ButtonStyle.large.height,
        );
      default:
        return (
          width: ButtonStyle.medium.width,
          height: ButtonStyle.medium.height,
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
      case ButtonSize.fit:
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
      return const BorderSide(
        color: Dark.gray400,
        width: 1,
      );
    }

    return const BorderSide(
      color: Colors.transparent,
      width: 0,
    );
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
        return Dark.gray050;
      default:
        return Dark.gray700;
    }
  }

  Widget _iconButton(IconData icon) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onIconPressed,
      icon: Icon(
        icon,
        color: iconColor ?? _getTextColor(),
      ),
      iconSize: 20,
      visualDensity: const VisualDensity(
        vertical: -4,
        horizontal: -2,
      ),
    );
  }

  Widget _getButtonChild(String text, IconData? leftIcon, IconData? rightIcon) {
    if (leftIcon != null) {
      return Row(
        mainAxisSize:
            size == ButtonSize.fit ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconButton(leftIcon),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    if (rightIcon != null) {
      return Row(
        mainAxisSize:
            size == ButtonSize.fit ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          _iconButton(rightIcon),
        ],
      );
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size == ButtonSize.fit ? null : _getButtonSize().width,
      height: size == ButtonSize.fit ? null : _getButtonSize().height,
      child: OutlinedButton(
        onPressed: type == ButtonType.disable ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: padding ?? EdgeInsets.zero,
          side: _getBorderStyle(),
          backgroundColor: bgColor ?? _getBgColor(),
          foregroundColor: textColor ?? _getTextColor(),
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
