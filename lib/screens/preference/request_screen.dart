import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/open_bottom_sheet.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

import 'package:sul_sul/widgets/header.dart';
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
  // TODO: 유저 닉네임 변경
  static const message =
      '안녕하세요 000님!\n서비스 초기여서, 원하시는 안주가 많이 없죠..?\n아래에 원하셨던 안주 정보를 입력해주시면,\n더 다양한 안주를 추가할 수 있도록 술술팀이 열심히 달려보겠습니다. 조금만 기다려주세요!!\n\n-2023년이 한달 남은 순간에, 술술팀 드림 🎅🏻';
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _scrollKey = GlobalKey();
  final int maxLength = 30;

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
    var data = {
      'type': type,
      'subtype': subtype,
      'name': food,
    };

    // TODO: 안주 등록 api
  }

  Widget _categoryDropdown() {
    // TODO: dropdown 공통 위젯 변경
    return Container(
      padding: const EdgeInsets.all(10),
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
          margin: const EdgeInsets.all(10),
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
      appBar: const Header(
        title: '찾는 안주가 없어요...',
        extend: true,
        type: HeaderType.back,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        child: const Row(
                          children: [
                            Text(
                              '안주 이름 ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '(필수)',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
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
                        child: const Row(
                          children: [
                            Text(
                              '카테고리 선택 ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '(선택)',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Dark.gray400,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
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
            padding: 14,
            child: Button(
              title: '제출하기',
              onPressed: () => _onSubmit('안주'),
              size: ButtonSize.large,
              type: isValid ? ButtonType.active : ButtonType.disable,
            ),
          ),
        ],
      ),
    );
  }
}
