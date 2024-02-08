import 'package:flutter/material.dart';

import 'package:sul_sul/widgets/home/home_title.dart';
import 'package:sul_sul/widgets/home/feed_card.dart';

// TODO: Alcohol / Food → Pairing 상위 객체 생성하기
class UniquePairList extends StatelessWidget {
  final List<dynamic> pairList;

  const UniquePairList({super.key, required this.pairList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: HomeTitle(
            title: '색다른 조합',
            subtitle: '맨날 먹던거만 먹으면 질리니까!!\n새로 만나는 우리, 제법 잘...어울릴지도??',
          ),
        ),
        for (var pair in pairList)
          const FeedCard(
            // title: pair.title,
            // writer: pair.writer,
            // image: pair.image,
            // food: pair.foods,
            // alcohol: pair.alcohols,
            // content: pair.content,
            // score: pair.score,
            title: '디지털 마케팅의 핵심 원리와 성공 전략',
            writer: '유저닉네임',
            image:
                'https://recipe1.ezmember.co.kr/cache/recipe/2020/11/11/6303fec09cd55eb03898052936d0d8671.png',
            food: '삼겹살',
            alcohol: '처음처럼',
            content:
                '이번에 위스키를 처음 먹어봤습니다.\n맨날 하이볼로만 먹다가 온더락으로 마셔봤는데, 향이 좋았습니다. 안주의 맛이 강하지 않은 나초 오리지널과 먹어봤습니다.\n취하기 위해서, 맛으로 먹기보다는 본연의 맛을 느껴보는것도 좋은 경험이네요!',
            score: 4.2,
          ),
      ],
    );
  }
}
