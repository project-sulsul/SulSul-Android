import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/providers/pairings_provider.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/verification.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/home/popular_pair_card.dart';
import 'package:sul_sul/widgets/home/recommendation.dart';
import 'package:sul_sul/widgets/top_action_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PreferenceRepository preferenceRepository =
      PreferenceRepository(apiClient: sulsulServer);

// FIXME: provider로 유저 데이터 받아오기 (취향 설정 여부)
  bool preference = false;
  List<dynamic> popularPairList = [];

  @override
  void initState() {
    _getPopularPairList();
    super.initState();
  }

  void _getPopularPairList() {
    // TODO: 좋아요 많은 조합 목록 불러오기
    setState(() {
      popularPairList = ['근-본 치맥', '질수없다 삼쏘!', '나도 (물)고기다! 회쏘! 🐟🥃'];
    });
  }

  Divider _divider() {
    return const Divider(
      height: 10,
      thickness: 10,
      color: Dark.gray100,
    );
  }

  Widget _title({
    required String title,
    String? subtitle,
    String? target,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EasyRichText(
          title,
          patternList: [
            if (target != null)
              EasyRichTextPattern(
                targetString: target,
                style: const TextStyle(
                  color: Main.main,
                ),
              ),
          ],
          defaultStyle: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Dark.gray500,
            ),
          )
      ],
    );
  }

  Widget _category({
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

  Widget _popularPairList(List<dynamic> list) {
    var lastIndex = list.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _title(
            title: '좋아요 많은 조합',
            subtitle: '자주, 늘 먹는데에는 이유가 있는 법!',
          ),
        ),
        for (var pair in list)
          Container(
            margin: EdgeInsets.only(
              bottom: list.indexOf(pair) == lastIndex ? 0 : 24,
            ),
            child: PopularPairCard(
              title: pair,
              imageList: const [
                'https://recipe1.ezmember.co.kr/cache/recipe/2020/11/11/6303fec09cd55eb03898052936d0d8671.png',
                'https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg',
                'https://shop-hongli.com/data/item/1675384084/thumb-7IqI7Y287LC47LmY7IS47Yq42_650x650.png',
              ],
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Button(
            title: '더 많은 조합 보러가기',
            onPressed: () {},
            type: ButtonType.plane,
            size: ButtonSize.large,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    PairingsProvider provider = context.watch<PairingsProvider>();
    Set<String> categoryList = provider.alcoholCategory;
    String selectedAlcohol = provider.selectedAlcohol;
    String word = checkBottomConsonant(selectedAlcohol) ? '이랑' : '랑';

    return Scaffold(
      appBar: const TopActionBar(
        action: ActionType.notice,
      ),
      body: RefreshIndicator(
        // TODO: 초기화 함수 추가
        onRefresh: () async {},
        color: Dark.gray900,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: preference
                  ? _title(
                      // TODO: 유저 닉네임 변경
                      title: '보라색 하이볼님이 선택한\n취향으로 골라봤어요.',
                      target: '보라색 하이볼',
                    )
                  : _title(
                      title: '$selectedAlcohol이랑 어울리는\n안주로 골라봤어요!',
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
                child: preference
                    ? _title(
                        // TODO: 유저 닉네임 변경
                        text: '보라색 하이볼님이 선택한\n취향으로 골라봤어요.',
                        target: '보라색 하이볼',
                      )
                    : _title(
                        text: '$selectedAlcohol$word 어울리는\n안주로 골라봤어요!',
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
                    child: _category(
                      provider: provider,
                      alcoholList: categoryList,
                      selected: selectedAlcohol,
                    ),
                  ),
                ),
              Recommendation(
                alcohol: selectedAlcohol,
                isPreference: preference,
                userName: '보라색 하이볼',
              ),
              _divider(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: _title(text: '좋아요 많은 조합'),
                    ),
                  ],
                ),
              ),
            Recommendation(
              alcohol: selectedAlcohol,
              isPreference: preference,
              userName: '보라색 하이볼',
            ),
            _divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: _popularPairList(popularPairList),
            ),
            _divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: _title(title: '색다른 조합'),
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
