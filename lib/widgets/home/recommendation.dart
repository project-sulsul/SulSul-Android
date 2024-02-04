import 'package:flutter/material.dart';

import 'package:sul_sul/models/feed_model.dart';
import 'package:sul_sul/models/feed_repository.dart';
import 'package:sul_sul/utils/api/api_client.dart';

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
  FeedRepository feedRepository = FeedRepository(apiClient: sulsulServer);

  List<FeedsResponse> pairList = [];

  @override
  void initState() {
    _getPairList();
    super.initState();
  }

  void _getPairList() async {
    // TODO: 회원 pair list 호출
    if (widget.userName != null) {
      setState(() {
        pairList = [];
      });
      return;
    }

    var response = await feedRepository.getFeedListByAlcohol();

    setState(() {
      pairList = response ?? [];
    });
  }

  Widget _recommendedCard() {
    if (pairList.isEmpty) {
      return AutoCarouselCard(
        name: '${widget.userName}',
        alcohol: widget.alcohol,
        imageList: const [],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var pair in pairList.where((p) => p.subtype == widget.alcohol))
              PairCard(
                title: pair.title,
                writer: pair.writer,
                image: pair.image,
                food: pair.foods[0],
                alcohol: pair.alcohols?[0],
                score: pair.score,
              ),
          ],
        ),
      ),
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
