import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

class TopActionBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool extend;
  final ActionType? action;
  final ActionBarType? type;
  final String? textButtonName;
  final String? subtitle;
  final void Function()? onPressedTextButton;

  const TopActionBar({
    super.key,
    this.title = '',
    this.extend = false,
    this.action,
    this.type,
    this.textButtonName,
    this.subtitle,
    this.onPressedTextButton,
  });

  Widget? _title() {
    if (extend) return null;

    if (type == ActionBarType.none) {
      return Container(
        color: const Color(0xFFD9D9D9),
        width: 100,
        height: 24,
      );
    }

    return Center(
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Dark.gray900,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget? _leading(BuildContext context) {
    if (type != ActionBarType.back) return null;

    return IconButton(
      onPressed: () => Navigator.pop(context),
      color: Dark.gray900,
      icon: const Icon(
        CustomIcons.arrow_back,
      ),
    );
  }

  List<Widget> _actions() {
    return [
      if (action == ActionType.notice)
        IconButton(
          onPressed: () {},
          icon: const Icon(CustomIcons.search_outlined),
        ),
      if (action == ActionType.notice)
        IconButton(
          onPressed: () {},
          icon: const Icon(CustomIcons.notification_outlined),
        ),
      if (action == ActionType.setting)
        IconButton(
          onPressed: () {},
          icon: const Icon(CustomIcons.setting_outlined),
        ),
      if (action == ActionType.like)
        IconButton(
          onPressed: () {},
          icon: const Icon(CustomIcons.heart_outlined),
        ),
      if (action == ActionType.like || action == ActionType.more)
        IconButton(
          onPressed: () {},
          icon: const Icon(CustomIcons.more_vert),
        ),
      if (action == ActionType.text)
        TextButton(
          onPressed: onPressedTextButton,
          child: Text(
            textButtonName ?? '',
            style: const TextStyle(
              color: Main.main,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
    ];
  }

  PreferredSizeWidget? _bottom() {
    if (!extend) return null;

    return PreferredSize(
      preferredSize: const Size.fromHeight(double.infinity),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  color: Dark.gray900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (subtitle != null)
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  subtitle ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Dark.gray900,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      backgroundColor: Dark.black,
      titleTextStyle: const TextStyle(color: Dark.white),
      title: _title(),
      leading: _leading(context),
      actions: _actions(),
      bottom: _bottom(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(extend && subtitle != null
      ? 100 + 30 * subtitle!.split('\n').length.toDouble()
      : extend && subtitle == null
          ? 100
          : kToolbarHeight);
}
