import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final String? placeholder;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  const Input({
    super.key,
    required this.controller,
    required this.onChanged,
    this.placeholder,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    Color color = controller.text.isEmpty ? Dark.gray400 : Dark.gray900;

    return TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: Dark.gray900,
      style: const TextStyle(
        color: Dark.gray900,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(color: Dark.gray400),
        prefixIcon: Icon(
          prefixIcon,
          color: color,
        ),
        suffixIcon: Icon(
          suffixIcon,
          color: color,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Dark.gray900),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        contentPadding: const EdgeInsets.all(14),
      ),
    );
  }
}
