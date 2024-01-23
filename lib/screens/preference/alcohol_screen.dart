import 'package:flutter/material.dart';

import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/screens/preference/food_screen.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/route.dart';

import 'package:sul_sul/widgets/header.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/preference/alcohol_card.dart';
import 'package:sul_sul/widgets/blur_container.dart';
import 'package:sul_sul/widgets/modal.dart';
import 'package:sul_sul/widgets/preference/sub_header.dart';

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
    var response = await preferenceRepository.getPreferenceList(type);
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return const Modal(
            title: '선택 불가',
            subtitle: '3개 이상 선택할 수 없어요',
          );
        }),
      );
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

  @override
  Widget build(BuildContext context) {
    int count = alcoholList.where((p) => p.isSelected == true).length;

    void onPressNextButton() {
      var alcohol = alcoholList
          .where((pair) => pair.isSelected == true)
          .map((p) => p.id)
          .toList();

      Navigator.of(context)
          .push(createRoute(PreferenceFoodScreen(alcohol: alcohol)));
    }

    return Scaffold(
      appBar: const Header(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SubHeader(title: '주로 마시는 술', num: 1, count: count, maxNum: maxNum),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Wrap(
                  spacing: 16,
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
              scroll: true,
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
