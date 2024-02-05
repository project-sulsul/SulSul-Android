import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/models/feed/popular_feed_model.dart';
import 'package:sul_sul/models/feed/popular_feed_repository.dart';
import 'package:sul_sul/models/feed_model.dart';
import 'package:sul_sul/models/feed_repository.dart';
import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/providers/main_provider.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/home/home_title.dart';
import 'package:sul_sul/widgets/home/popular_pair_list.dart';
import 'package:sul_sul/widgets/home/recommend_pair_list.dart';
import 'package:sul_sul/widgets/top_action_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PreferenceRepository preferenceRepository =
      PreferenceRepository(apiClient: sulsulServer);
  FeedRepository feedRepository = FeedRepository(apiClient: sulsulServer);
  PopularFeedRepository popularFeedRepository =
      PopularFeedRepository(apiClient: sulsulServer);

// FIXME: provider로 유저 데이터 받아오기 (취향 설정 여부)
  bool preference = true;
  List<FeedsResponse> recommendPairList = [];
  List<PopularFeedResponse> popularPairList = [];

  @override
  void initState() {
    _onRefresh();
    super.initState();
  }

  void _getRecommendPairList() async {
    if (preference) {
      var response = await feedRepository.getFeedListByPreference();
      setState(() {
        recommendPairList = response ?? [];
      });
      return;
    }

    var response = await feedRepository.getFeedListByAlcohol();
    setState(() {
      recommendPairList = response ?? [];
    });
  }

  void _getPopularPairList() async {
    var response = await popularFeedRepository.getPopularFeedList();

    setState(() {
      popularPairList = response;
    });
  }

  Future<void> _onRefresh() async {
    _getPopularPairList();
    _getRecommendPairList();
  }

  Divider _divider() {
    return const Divider(
      height: 10,
      thickness: 10,
      color: Dark.gray100,
    );
  }

  @override
  Widget build(BuildContext context) {
    void navigate(int screenIndex) {
      context.read<MainProvider>().navigate(screenIndex);
    }

    return Scaffold(
      appBar: const TopActionBar(
        action: ActionType.notice,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Dark.gray900,
        child: ListView(
          children: [
            RecommendPairList(
              preference: preference,
              pairList: recommendPairList,
            ),
            _divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: PopularPairList(
                pairList: popularPairList,
                onPressed: navigate,
              ),
            ),
            _divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: HomeTitle(title: '색다른 조합'),
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
