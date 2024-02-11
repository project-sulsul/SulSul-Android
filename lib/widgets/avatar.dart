import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sul_sul/theme/colors.dart';

class Avatar extends StatelessWidget {
  final double borderRadius;
  final double width;
  final double height;
  final String? image;
  final XFile? file;

  const Avatar({
    super.key,
    required this.borderRadius,
    this.width = 60,
    this.height = 60,
    this.image,
    this.file,
  });

  Widget _image() {
    if (file != null) {
      return Image.file(
        File(file!.path),
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
    return Image.network(
      image!,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Dark.gray100,
      ),
      clipBehavior: Clip.hardEdge,
      child: _image(),
    );
  }
}
