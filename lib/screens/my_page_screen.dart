import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/providers/user_provider.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/route.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/screens/update_nickname_screen.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/sul_tab_bar.dart';
import 'package:sul_sul/widgets/avatar.dart';

class MyPageScreen extends StatelessWidget {
  static const List<String> tabList = ['나의 피드', '좋아요 표시한 피드'];

  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? userName = context.watch<UserProvider>().nickname;
    String? userImage = context.watch<UserProvider>().image;

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
                      if (userName != null)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              createRoute(
                                const UpdateNicknameScreen(
                                  isUpdate: true,
                                ),
                              ),
                            ),
                            splashColor: Dark.gray050,
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
                    ],
                  ),
                  Avatar(
                    image: userImage,
                    width: 64,
                    height: 64,
                    borderRadius: 32,
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
