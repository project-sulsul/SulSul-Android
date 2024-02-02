import 'package:flutter/material.dart';

import 'package:sul_sul/widgets/home/auto_carousel_card.dart';
import 'package:sul_sul/widgets/home/pair_card.dart';

class Recommendation extends StatefulWidget {
  final String alcohol;
  final String? userName;
  final bool isPreference;

  const Recommendation({
    super.key,
    required this.alcohol,
    this.userName,
    this.isPreference = false,
  });

  @override
  State<Recommendation> createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  List<dynamic> pairList = [];

  @override
  void initState() {
    pairList = ['삼겹살', '치킨', '회'];
    super.initState();
  }

  Widget _recommendedCard() {
    if (widget.userName != null && !widget.isPreference) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var pair in pairList)
              const PairCard(
                title: '새로운 취미 시작하기:창작의 기쁨과 성취감',
                writer: '@유저닉네임',
                image:
                    'https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg',
                food: '삼겹살',
                alcohol: '소주',
                score: 4.2,
              ),
          ],
        ),
      );
    }

    if (widget.isPreference) {
      // TODO: 회원 + 취향 설정한 경우
    }

    return AutoCarouselCard(
      name: '000',
      alcohol: widget.alcohol,
      imageList: const [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 16,
        bottom: 24,
      ),
      child: _recommendedCard(),
    );
  }
}
