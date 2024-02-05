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
              Flexible(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.amber,
                  margin: const EdgeInsets.only(right: 9),
                  child: Image.network(
                    imageList[0],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.red,
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Image.network(
                          imageList[1],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.green,
                        child: Image.network(
                          imageList[2],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
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
