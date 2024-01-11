import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/header.dart';
import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/alcohol_card.dart';

class PreferenceAlcohol extends StatefulWidget {
  const PreferenceAlcohol({super.key});

  @override
  State<PreferenceAlcohol> createState() => _PreferenceState();
}

class _PreferenceState extends State<PreferenceAlcohol> {
  static const maxNum = 3;

  // TODO: get 주종 리스트
  List<Map<String, Object?>> pairngList = [
    {
      "id": 1,
      "type": "술",
      "subtype": "소주",
      "name": "처음처럼",
      "image":
          "https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg",
      "description": "처음처럼입니다",
      "isSelected": false,
    },
    {
      "id": 2,
      "type": "술",
      "subtype": "소주",
      "name": "참이슬",
      "image":
          "https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg",
      "description": "참이슬입니다",
      "isSelected": false,
    },
    {
      "id": 3,
      "type": "술",
      "subtype": "소주",
      "name": "좋은데이",
      "image":
          "https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg",
      "description": "좋은데이입니다",
      "isSelected": false,
    },
    {
      "id": 4,
      "type": "술",
      "subtype": "소주",
      "name": "진로",
      "image":
          "https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg",
      "description": "진로입니다",
      "isSelected": false,
    },
    {
      "id": 5,
      "type": "술",
      "subtype": "소주",
      "name": "새로",
      "image":
          "https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg",
      "description": "새로입니다",
      "isSelected": true,
    },
    {
      "id": 6,
      "type": "술",
      "subtype": "소주",
      "name": "새로",
      "image":
          "https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg",
      "description": "새로입니다",
      "isSelected": true,
    },
    {
      "id": 7,
      "type": "술",
      "subtype": "소주",
      "name": "좋은데이",
      "image":
          "https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg",
      "description": "좋은데이입니다",
      "isSelected": false,
    },
    {
      "id": 8,
      "type": "술",
      "subtype": "소주",
      "name": "좋은데이",
      "image":
          "https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg",
      "description": "좋은데이입니다",
      "isSelected": false,
    },
  ];

  void _onSelectCard(int id) {
    var isValid = pairngList
            .where((p) => p['id'] == id && p['isSelected'] == true)
            .isEmpty &&
        pairngList.where((p) => p['isSelected'] == true).length >= maxNum;

    if (isValid) {
      // TODO: 모달 띄우기
      return;
    }

    setState(() {
      pairngList = pairngList
          .map((p) => p['id'] == id
              ? {...p, 'isSelected': !(p['isSelected'] == true)}
              : p)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var count = pairngList.where((p) => p['isSelected'] == true).length;

    void onPressNextButton() {
      var alcohol = pairngList
          .where((pair) => pair['isSelected'] == true)
          .map((p) => p['id'])
          .toList();

      // Navigator.pushNamed(context, '/preference-food', arguments: alcohol); // TODO: 안주 선택으로 이동
      print(alcohol);
    }

    return Scaffold(
      appBar: const Header(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Wrap(
                  spacing: 16.0,
                  children: [
                    for (var item in pairngList)
                      AlcoholCard(
                        text: '${item['subtype']}',
                        image: '${item['image']}',
                        id: int.parse('${item['id']}'),
                        isSelected: item['isSelected'] == true,
                        onTap: _onSelectCard,
                      ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 20,
                    blurRadius: 25,
                  ),
                ],
              ),
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
