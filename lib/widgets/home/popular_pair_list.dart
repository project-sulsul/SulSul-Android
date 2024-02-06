import 'package:flutter/material.dart';

import 'package:sul_sul/models/feed/popular_feed_model.dart';

import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/home/home_title.dart';
import 'package:sul_sul/widgets/home/popular_pair_card.dart';

class PopularPairList extends StatelessWidget {
  final List<PopularFeedResponse> pairList;
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
              id: pair.id,
              title: pair.title,
              imageList: const [
                // FIXME: 서버 데이터 합의 이후 변경 예정
                'https://recipe1.ezmember.co.kr/cache/recipe/2020/11/11/6303fec09cd55eb03898052936d0d8671.png',
                'https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg',
                'https://shop-hongli.com/data/item/1675384084/thumb-7IqI7Y287LC47LmY7IS47Yq42_650x650.png',
              ],
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
