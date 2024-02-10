import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

class PopularPairCard extends StatelessWidget {
  final String title;
  final List<String> imageList;

  const PopularPairCard({
    super.key,
    required this.title,
    required this.imageList,
  });

  Widget _image({
    required int flex,
    required String src,
    EdgeInsetsGeometry? margin,
  }) {
    return Flexible(
      flex: flex,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: margin,
        child: Image.network(
          src,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                CustomIcons.arrow_forward,
                color: Dark.gray900,
              ),
            ],
          ),
        ),
        Container(
          height: 232,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              _image(
                flex: 2,
                src: imageList[0],
                margin: const EdgeInsets.only(right: 9),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    for (var image in imageList.sublist(1))
                      _image(
                        flex: 1,
                        src: image,
                        margin: const EdgeInsets.only(bottom: 8),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
