import 'package:flutter/material.dart';

import 'package:sul_sul/models/feed/feed_model.dart';

import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/home/home_title.dart';
import 'package:sul_sul/widgets/home/popular_pair_card.dart';

class PopularPairList extends StatelessWidget {
  final List<PopularFeed> pairList;
  final void Function(int) onPressed;

  const PopularPairList({
    super.key,
    required this.pairList,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    int lastIndex = pairList.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: HomeTitle(
            title: '좋아요 많은 조합',
            subtitle: '자주, 늘 먹는데에는 이유가 있는 법!',
          ),
        ),
        for (var pair in pairList)
          Container(
            margin: EdgeInsets.only(
              bottom: pairList.indexOf(pair) == lastIndex ? 0 : 24,
            ),
            child: PopularPairCard(
              title: pair.title,
              imageList: pair.images,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Button(
            title: '더 많은 조합 보러가기!',
            onPressed: () => onPressed(ScreenIndex.ranking.index),
            type: ButtonType.plane,
            size: ButtonSize.large,
          ),
        )
      ],
    );
  }
}
