import 'package:flutter/material.dart';

import 'package:sul_sul/models/rank_repository.dart';
import 'package:sul_sul/models/rank_model.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/rank/tear_card.dart';
import 'package:sul_sul/widgets/sul_tab_bar.dart';
import 'package:sul_sul/widgets/top_action_bar.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  static const List<String> tabList = ['술', '술+안주'];

  RankRepository rankRepository = RankRepository(apiClient: sulsulServer);

  RankResponse? alcoholRankList;
  RankResponse? combinationRankList;

  @override
  void initState() {
    // TODO: 랭킹 조회
    _getAlcoholRankList();
    _getCombinationRankList();
    super.initState();
  }

  void _getAlcoholRankList() async {
    var alcoholList = await rankRepository.getAlcoholRankList();

    setState(() {
      alcoholRankList = alcoholList;
    });
  }

  void _getCombinationRankList() async {
    var combinationList = await rankRepository.getCombinationRankList();

    setState(() {
      combinationRankList = combinationList;
    });
  }

  Widget _title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          '이번주 랭킹',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Dark.gray900,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Text(
            // FIXME: 술+안주 조합 랭킹 기간 수정
            alcoholRankList == null
                ? ''
                : '${alcoholRankList?.startDate} ~ ${alcoholRankList?.endDate}',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Dark.gray600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _rankList({
    required RankType type,
    RankResponse? list,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          if (type == RankType.alcohol)
            for (AlcoholRankResponse rank in list?.ranking ?? [])
              TearCard(
                alcoholName: rank.alcohol.name,
                alcoholImage: rank.alcohol.image ?? '',
                rank: rank.rank,
                onTap: () {},
              ),
          if (type == RankType.combination)
            for (CombinationRankResponse rank in list?.ranking ?? [])
              TearCard(
                alcoholName: rank.pairings[0].name,
                alcoholImage: rank.pairings[0].image ?? '',
                foodName: rank.pairings[1].name,
                foodImage: rank.pairings[1].image ?? '',
                rank: rank.rank,
                onTap: () {},
              ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopActionBar(
        action: ActionType.notice,
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: tabList.length,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _title(),
              ),
              const SulTabBar(tabList: tabList),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: _rankList(
                        type: RankType.alcohol,
                        list: alcoholRankList,
                      ),
                    ),
                    SingleChildScrollView(
                      child: _rankList(
                        type: RankType.combination,
                        list: combinationRankList,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
