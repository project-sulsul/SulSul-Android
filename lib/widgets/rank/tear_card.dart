import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/avatar.dart';

class TearCard extends StatelessWidget {
  final String alcoholName;
  final String alcoholImage;
  final int rank;
  final String? foodName;
  final String? foodImage;
  final List<String>? tags;
  final void Function()? onTap;

  const TearCard({
    super.key,
    required this.alcoholName,
    required this.alcoholImage,
    required this.rank,
    this.foodName,
    this.foodImage,
    this.tags,
    this.onTap,
  });

  Widget _name() {
    if (foodName != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            alcoholName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '& $foodName',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        // TODO: 태그
        if (tags != null)
          const Row(
            children: [],
          ),
        Text(
          alcoholName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Dark.gray900,
          ),
        ),
      ],
    );
  }

  Widget _image() {
    if (foodImage != null) {
      return Row(
        children: [
          Transform.translate(
            offset: const Offset(54, 0),
            child: Avatar(
              image: foodImage!,
              borderRadius: 25.7,
            ),
          ),
          Transform.translate(
            offset: const Offset(-54, 0),
            child: Avatar(
              image: alcoholImage,
              borderRadius: 25.7,
            ),
          ),
        ],
      );
    }

    return Image.network(
      alcoholImage,
      width: 70,
      height: 70,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Dark.gray050,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: foodName != null ? 13 : 8,
          horizontal: 10,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 38,
              child: Column(
                children: [
                  Text(
                    '$rank',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // TODO: 순위 증가 / 감소 추가
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Dark.gray300,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _image(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _name(),
            ),
          ],
        ),
      ),
    );
  }
}
