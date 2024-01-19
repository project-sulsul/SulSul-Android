import 'package:flutter/material.dart';

import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/widgets/blur_container.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/food_card.dart';
import 'package:sul_sul/widgets/header.dart';
import 'package:sul_sul/widgets/input.dart';
import 'package:sul_sul/widgets/modal.dart';
import 'package:sul_sul/widgets/preference/sub_header.dart';

class PreferenceFoodScreen extends StatefulWidget {
  final List<PreferenceResponse>? alcohol;

  const PreferenceFoodScreen({super.key, this.alcohol});

  @override
  State<PreferenceFoodScreen> createState() => _PreferenceFoodScreenState();
}

class _PreferenceFoodScreenState extends State<PreferenceFoodScreen> {
  static const int maxNum = 5;
  static const String notice =
      '앗, 죄송해요! 😅\n입력하신 안주가 아직 등록되지 않은것 같아요.\n저희가 몰랐던 다양한 안주를 알려주시겠어요?';

  final TextEditingController _controller = TextEditingController();

  PreferenceRepository preferenceRepository =
      PreferenceRepository(apiClient: sulsulServer);
  List<PreferenceResponse> foodList = [];
  List<PreferenceResponse> filteredFoodList = [];

  @override
  void initState() {
    super.initState();
    _getPreferenceList(Pairings.food);
  }

  void _getPreferenceList(String type) async {
    var response = await preferenceRepository.getPreferenceList(type);
    setState(() {
      foodList = response ?? [];
      filteredFoodList = response ?? [];
    });
  }

  void _searchFood(text) {
    setState(() {
      filteredFoodList =
          foodList.where((food) => food.name.contains(text)).toList();
    });
  }

  void _onSelectCard(int id) {
    var isInvalid = foodList
            .where((food) => food.id == id && food.isSelected == true)
            .isEmpty &&
        foodList.where((p) => p.isSelected == true).length >= maxNum;

    if (isInvalid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: ((context) {
          return const Modal(
            title: '선택 불가',
            subtitle: '$maxNum개 이상 선택할 수 없어요',
          );
        }),
      );
      return;
    }

    var newList = foodList
        .map((food) => food.id == id
            ? PreferenceResponse.fromJson({
                ...food.toJson(),
                "isSelected": !food.isSelected,
              })
            : food)
        .toList();

    var newFilteredList = filteredFoodList
        .map((food) => food.id == id
            ? PreferenceResponse.fromJson({
                ...food.toJson(),
                "isSelected": !food.isSelected,
              })
            : food)
        .toList();
    setState(() {
      foodList = newList;
      filteredFoodList = newFilteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    int count = foodList.where((p) => p.isSelected == true).length;

    void onPressNextButton() {
      var food = foodList
          .where((pair) => pair.isSelected == true)
          .map((p) => p.id)
          .toList();

      var data = {
        "alchol": widget.alcohol,
        "foods": food,
      };

      preferenceRepository
          .updateUserPreference(data) //
          .then((res) => Navigator.pushNamedAndRemoveUntil(
              context, '/home', (route) => false));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const Header(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SubHeader(title: '함께 먹는 안주', num: 2, count: count, maxNum: maxNum),
            Input(
              controller: _controller,
              onChanged: _searchFood,
              placeholder: '안주이름을 검색해보세요',
              prefixIcon: CustomIcons.search_outlined,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredFoodList.isNotEmpty
                  ? ListView(
                      padding: const EdgeInsets.only(bottom: 20),
                      children: [
                          for (var food in filteredFoodList)
                            FoodCard(
                              subtype: food.subtype,
                              name: food.name,
                              search: _controller.text,
                              id: food.id,
                              isSelected: food.isSelected,
                              onTap: _onSelectCard,
                            )
                        ])
                  : ListView(
                      children: [
                        Column(
                          children: [
                            const SizedBox(height: 60),
                            const Text(
                              notice,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Dark.gray600,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 60),
                            Button(
                              title: '안주 추가하러 가기',
                              onPressed: () => Navigator.pushNamed(
                                  context, '/request-pairings'),
                              size: ButtonSize.fit,
                            ),
                            const SizedBox(height: 60),
                          ],
                        ),
                      ],
                    ),
            ),
            if (filteredFoodList.isNotEmpty)
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
