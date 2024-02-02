import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/button.dart';

class SulBottomSheet extends StatelessWidget {
  final String title;
  final bool button;
  final bool isVertical;
  final BottomsheetType type;
  final String? content;
  final String? firstButtonText;
  final String? secondButtonText;
  final Color? secondButtonTextColor;
  final Color? secondButtonBgColor;
  final void Function()? onPressedfirstButton;
  final void Function()? onPressedsecondButton;

  const SulBottomSheet({
    super.key,
    required this.title,
    this.button = false,
    this.isVertical = false,
    this.type = BottomsheetType.normal,
    this.content,
    this.firstButtonText,
    this.secondButtonText,
    this.secondButtonTextColor,
    this.secondButtonBgColor,
    this.onPressedfirstButton,
    this.onPressedsecondButton,
  });

  EdgeInsetsGeometry _margin() {
    if (type == BottomsheetType.floating) {
      return const EdgeInsets.only(
        top: 10,
        bottom: 25,
        left: 10,
        right: 10,
      );
    }

    return EdgeInsets.zero;
  }

  Widget _buttonContainer({required List<Widget> children}) {
    if (isVertical) {
      return Column(
        children: children,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }

  Widget _contents({required double width, required void Function() onClose}) {
    var buttonWidth = isVertical
        ? width
        : type == BottomsheetType.floating
            ? width * 0.41
            : width * 0.43;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: SizedBox(
            height: 6,
            width: 40,
            child: Container(
              decoration: const BoxDecoration(
                color: Dark.gray300,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (content != null)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    content ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        _buttonContainer(
          children: [
            if (firstButtonText != null)
              SizedBox(
                width: buttonWidth,
                child: Button(
                  title: firstButtonText ?? '',
                  onPressed: onPressedfirstButton ?? onClose,
                  size: ButtonSize.large,
                ),
              ),
            if (secondButtonText != null)
              SizedBox(
                width: buttonWidth,
                child: Button(
                  title: secondButtonText ?? '',
                  onPressed: () {
                    onClose();
                    if (onPressedsecondButton != null) onPressedsecondButton!();
                  },
                  size: ButtonSize.large,
                  textColor: secondButtonTextColor,
                  bgColor: secondButtonBgColor,
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    void onClose() {
      Navigator.of(context).pop();
    }

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter bottomState) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 25,
            left: 24,
            right: 24,
          ),
          margin: _margin(),
          decoration: BoxDecoration(
            color: Dark.gray050,
            borderRadius: type == BottomsheetType.floating
                ? const BorderRadius.all(Radius.circular(25))
                : const BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: _contents(
            width: width,
            onClose: onClose,
          ),
        );
      },
    );
  }
}
