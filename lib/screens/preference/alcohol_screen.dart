import 'package:flutter/material.dart';

import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/header.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/alcohol_card.dart';
import 'package:sul_sul/widgets/blur_container.dart';
import 'package:sul_sul/widgets/notice_count.dart';

class PreferenceAlcoholScreen extends StatefulWidget {
  const PreferenceAlcoholScreen({super.key});

  @override
  State<PreferenceAlcoholScreen> createState() => _PreferenceState();
}

class _PreferenceState extends State<PreferenceAlcoholScreen> {
  static const maxNum = 3;

  PreferenceRepository preferenceRepository =
      PreferenceRepository(apiClient: sulsulServer);
  List<PreferenceResponse> alcoholList = [];

  @override
  void initState() {
    super.initState();
    _getPreferenceList(Pairings.alcohol);
  }

  void _getPreferenceList(String type) async {
    var response = await preferenceRepository.getPreferenceList('술');
    setState(() {
      alcoholList = response ?? [];
    });
  }

  void _onSelectCard(int id) {
    var isValid = alcoholList
            .where((alcohol) => alcohol.id == id && alcohol.isSelected == true)
            .isEmpty &&
        alcoholList.where((p) => p.isSelected == true).length >= maxNum;

    if (isValid) {
      // TODO: 모달 띄우기
      return;
    }

    var newList = alcoholList
        .map((alcohol) => alcohol.id == id
            ? PreferenceResponse.fromJson({
                ...alcohol.toJson(),
                "isSelected": !alcohol.isSelected,
              })
            : alcohol)
        .toList();
    setState(() {
      alcoholList = newList;
    });
  }

  Widget _subHeader(int count) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Q1.',
                    style: TextStyle(
                      fontSize: 20,
                      color: Dark.gray900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '주로 마시는 술',
                    style: TextStyle(
                      fontSize: 30,
                      color: Dark.gray900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$count개 ',
                    style: TextStyle(
                      color: count > 0 ? Main.main : Dark.gray300,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '선택됨',
                    style: TextStyle(
                      color: count > 0 ? Main.main : Dark.gray300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Positioned(
          right: 0,
          top: 18,
          child: NoticeCount(
            count: 3,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int count = alcoholList.where((p) => p.isSelected == true).length;

    void onPressNextButton() {
      var alcohol = alcoholList
          .where((pair) => pair.isSelected == true)
          .map((p) => p.id)
          .toList();

      // Navigator.pushNamed(context, '/preference-food', arguments: alcohol); // TODO: 안주 선택으로 이동
    }

    return Scaffold(
      appBar: const Header(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            _subHeader(count),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Wrap(
                  spacing: 16.0,
                  children: [
                    for (var item in alcoholList)
                      AlcoholCard(
                        text: item.name,
                        image: '${item.image}',
                        id: int.parse('${item.id}'),
                        isSelected: item.isSelected == true,
                        onTap: _onSelectCard,
                      ),
                  ],
                ),
              ),
            ),
            BlurContainer(
              child: Button(
                title: '다음',
                onPressed: onPressNextButton,
                size: ButtonSize.large,
                type: count > 0 ? ButtonType.active : ButtonType.disable,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
