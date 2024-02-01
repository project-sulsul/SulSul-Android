import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

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

  Widget _imageBadge(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(27),
      clipBehavior: Clip.hardEdge,
      child: Image.network(
        image,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _image() {
    if (foodImage != null) {
      return SizedBox(
        height: 70,
        child: Row(
          children: [
            Transform.translate(
              offset: const Offset(54, 0),
              child: _imageBadge(foodImage!),
            ),
            Transform.translate(
              offset: const Offset(-54, 0),
              child: _imageBadge(alcoholImage),
            ),
          ],
        ),
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
        padding: const EdgeInsets.symmetric(
          vertical: 8,
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
