import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';


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

  String selected = '';
  List<PreferenceResponse> alcoholList = [];

  @override
  void initState() {
    super.initState();
  }


  void _onSelectAlcohol(String alcohol) {
    setState(() {
      selected = alcohol;
    });
  }

  Divider _divider() {
    return const Divider(
      height: 10,
      thickness: 10,
      color: Dark.gray100,
    );
  }

  Widget _title() {
    return EasyRichText(
      '$selected랑 어울리는\n안주로 골라봤어요!',
      patternList: [
        EasyRichTextPattern(
          targetString: selected,
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

  Widget _category() {
    return Row(
      children: [
        for (var alcohol in alcoholList)
          Button(
            title: alcohol.name,
            onPressed: () => _onSelectAlcohol(alcohol.name),
            size: ButtonSize.mini,
            type:
                selected == alcohol.name ? ButtonType.active : ButtonType.plane,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: _title(),
              ),
              if (alcoholList.isNotEmpty) // FIXME: 취향 설정한 경우
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _category(),
                ),
              Recommendation(
                alcohol: selected,
                userName: 'hi',
                isPreference: true,
              ),
              _divider()
            ],
          ),
        ),
      ),
    );
  }
}
