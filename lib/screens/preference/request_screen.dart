import 'package:flutter/material.dart';

import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/open_bottom_sheet.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/input.dart';
import 'package:sul_sul/widgets/blur_container.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/preference/food_card.dart';

class RequestScreen extends StatefulWidget {
  final List<String> categoryList;

  const RequestScreen({super.key, required this.categoryList});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _scrollKey = GlobalKey();
  final int maxLength = 30;
  PreferenceRepository preferenceRepository =
      PreferenceRepository(apiClient: sulsulServer);
  // TODO: 유저 닉네임 변경
  final String message =
      '안녕하세요 000님!\n서비스 초기여서, 원하시는 안주가 많이 없죠..?\n아래에 원하셨던 안주 정보를 입력해주시면,\n더 다양한 안주를 추가할 수 있도록 술술팀이 열심히 달려보겠습니다. 조금만 기다려주세요!!\n\n-2023년이 한달 남은 순간에, 술술팀 드림 🎅🏻';

  String food = '';
  String subtype = '';

  void _changeValue(String text) {
    if (text.replaceAll(' ', '').length > maxLength) {
      _controller.text = text.substring(0, maxLength + 1);
    }

    setState(() {
      food = _controller.text;
    });
  }

  void _onTapInput() {
    Scrollable.ensureVisible(_scrollKey.currentContext!,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        alignment: 0);
  }

  void _onSubmit(String type) {
    var requestBody = PreferenceRequest.fromJson({
      'type': type,
      'subtype': subtype,
      'name': food,
    });

    preferenceRepository
        .postPairings(requestBody)
        .then((res) => Navigator.pop(context));
  }

  Widget _option({required String target, required bool required}) {
    return Row(
      children: [
        Text(
          '$target ',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          required ? '(필수)' : '(선택)',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: required ? Dark.gray900 : Dark.gray400,
          ),
        )
      ],
    );
  }

  Widget _categoryDropdown() {
    // TODO: dropdown 공통 위젯 변경
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 15,
        right: 10,
      ),
      decoration: BoxDecoration(
        color: subtype == '' ? Dark.gray050 : Dark.gray100,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subtype == '' ? '카테고리를 선택해주세요' : subtype,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: subtype == '' ? Dark.gray400 : Dark.gray900,
            ),
          ),
          subtype == ''
              ? const Icon(
                  CustomIcons.arrow_drop_down_filled,
                  color: Dark.gray400,
                  size: 35,
                )
              : const Icon(
                  CustomIcons.arrow_drop_up_filled,
                  color: Dark.gray900,
                  size: 35,
                ),
        ],
      ),
    );
  }

  Widget _bottomSheet() {
    // TODO: select 공통 위젯 변경
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter bottomState) {
        return Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 24,
            left: 10,
            right: 10,
          ),
          decoration: const BoxDecoration(
            color: Dark.gray050,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 6,
                  width: 40,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Dark.gray300,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '카테고리 선택',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (var category in widget.categoryList)
                      FoodCard(
                        subtype: category,
                        name: category,
                        id: widget.categoryList.indexOf(category),
                        isSelected: category == subtype,
                        onTap: (int i) {
                          bottomState(() {
                            setState(() {
                              subtype = widget.categoryList[i];
                            });
                          });
                        },
                      )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isValid = _controller.text.isNotEmpty;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const TopActionBar(
        title: '찾는 안주가 없어요...',
        extend: true,
        type: ActionBarType.back,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Dark.gray700,
                    ),
                  ),
                ),
                const Divider(
                  height: 60,
                  thickness: 8,
                  color: Dark.gray100,
                ),
                Padding(
                  key: _scrollKey,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '안주 정보 입력',
                        style: TextStyle(
                          fontSize: 24,
                          color: Dark.gray900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                        ),
                        child: _option(target: '안주 이름', required: true),
                      ),
                      Input(
                        controller: _controller,
                        onChanged: _changeValue,
                        onTap: _onTapInput,
                        placeholder: '안주 이름을 입력해주세요',
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                        ),
                        child: _option(target: '카테고리 선택', required: false),
                      ),
                      GestureDetector(
                        child: _categoryDropdown(),
                        onTap: () => openBottomSheet(context, _bottomSheet()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BlurContainer(
            padding: 20,
            child: Button(
              title: '제출하기',
              onPressed: () => _onSubmit(Pairings.food),
              size: ButtonSize.large,
              type: isValid ? ButtonType.active : ButtonType.disable,
            ),
          ),
        ],
      ),
    );
  }
}
