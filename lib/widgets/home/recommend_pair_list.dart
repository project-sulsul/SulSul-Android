import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/models/feed/recommend_feed_model.dart';
import 'package:sul_sul/providers/pairings_provider.dart';
import 'package:sul_sul/providers/user_provider.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/verification.dart';

import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/home/auto_carousel_card.dart';
import 'package:sul_sul/widgets/home/home_title.dart';
import 'package:sul_sul/widgets/home/feed_card.dart';

class RecommendPairList extends StatelessWidget {
  final bool preference;
  final List<RecommendFeedsResponse> pairList;

  const RecommendPairList({
    super.key,
    required this.preference,
    required this.pairList,
  });

  Widget _categoryList({
    required PairingsProvider provider,
    required String selected,
  }) {
    var alcoholList = provider.alcoholCategory;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var alcohol in alcoholList)
            Button(
              title: alcohol,
              onPressed: () => provider.selectAlcohol(alcohol),
              size: ButtonSize.mini,
              type: selected == alcohol ? ButtonType.active : ButtonType.plane,
              padding: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 24,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PairingsProvider pairingsProvider = context.watch<PairingsProvider>();

    String? userName = context.watch<UserProvider>().nickname ?? '';
    String selectedAlcohol = pairingsProvider.selectedAlcohol;
    String word = checkBottomConsonant(selectedAlcohol) ? '이랑' : '랑';

    List<RecommendFeedsResponse> filteredPairList = preference
        ? pairList
        : pairList.where((p) => p.subtype == selectedAlcohol).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 20,
            right: 20,
          ),
          child: preference
              ? HomeTitle(
                  title: '$userName님이 선택한\n취향으로 골라봤어요.',
                  target: userName,
                )
              : HomeTitle(
                  title: '$selectedAlcohol$word 어울리는\n안주로 골라봤어요!',
                  target: selectedAlcohol,
                ),
        ),
        if (!preference)
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _categoryList(
                provider: pairingsProvider,
                selected: selectedAlcohol,
              ),
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            top: 16,
            bottom: 24,
          ),
          child: filteredPairList.isEmpty
              ? AutoCarouselCard(
                  name: userName,
                  alcohol: selectedAlcohol,
                  imageList: const [],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (var pair in filteredPairList)
                          FeedCard(
                            title: pair.title,
                            writer: pair.writer,
                            image: pair.image,
                            food: pair.foods,
                            alcohol: pair.alcohols,
                            score: pair.score,
                          ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
