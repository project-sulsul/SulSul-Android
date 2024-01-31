import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class TearCard extends StatelessWidget {
  final String name;
  final String image;
  final int rank;
  final List<String>? tags;
  final void Function()? onTap;

  const TearCard({
    super.key,
    required this.name,
    required this.image,
    required this.rank,
    this.tags,
    this.onTap,
  });

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
                      color: Dark.gray900,
                    ),
                  ),
                  // TODO: 순위 증가 / 감소
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
              child: Image.network(
                image,
                width: 70,
                height: 70,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: [
                  // TODO: 태그
                  if (tags != null)
                    const Row(
                      children: [],
                    ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Dark.gray900,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
