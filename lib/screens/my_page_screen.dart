import 'package:flutter/material.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/sul_tab_bar.dart';

class MyPageScreen extends StatelessWidget {
  static const List<String> tabList = ['나의 피드', '좋아요 표시한 피드'];

  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: user 닉네임 불러오기 (provider)
    String? userName = '보라색 하이볼';

    return Scaffold(
      appBar: const TopActionBar(
        action: ActionType.setting,
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: tabList.length,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName ?? '로그인 해주세요!',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // ignore: unnecessary_null_comparison
                      if (userName != null)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: InkWell(
                            onTap: () {},
                            splashColor: Dark.gray050,
                            child: Container(
                              child: const Text(
                                '프로필 수정',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Dark.gray300,
                                ),
                              ),
                            ),
                          ),
                        ),

                      // ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      'https://i.pinimg.com/736x/2f/55/97/2f559707c3b04a1964b37856f00ad608.jpg',
                      width: 64,
                      height: 64,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: const Column(
                  children: [
                    SulTabBar(
                      tabList: tabList,
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(child: Text('나의 피드')),
                          SingleChildScrollView(child: Text('좋아요 표시한 피드')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
