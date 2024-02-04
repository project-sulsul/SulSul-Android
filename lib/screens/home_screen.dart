import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/providers/pairings_provider.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/button.dart';
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

  Divider _divider() {
    return const Divider(
      height: 10,
      thickness: 10,
      color: Dark.gray100,
    );
  }

  Widget _title({required String text, String? target}) {
    return EasyRichText(
      text,
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
    );
  }

  Widget _category({
    required PairingsProvider provider,
    required Set<String> alcoholList,
    required String selected,
  }) {
    return Row(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<PairingsProvider>();
    var categoryList = provider.alcoholCategory;
    var selectedAlcohol = provider.selectedAlcohol;

    return Scaffold(
      appBar: const TopActionBar(
        action: ActionType.notice,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
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
                        text: '$selectedAlcohol랑 어울리는\n안주로 골라봤어요!',
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
              _divider(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: _title(text: '색다른 조합'),
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
