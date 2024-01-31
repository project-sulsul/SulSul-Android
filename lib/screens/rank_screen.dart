import 'package:flutter/material.dart';
import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/widgets/sul_tab_bar.dart';
import 'package:sul_sul/widgets/top_action_bar.dart';

class RankScreen extends StatefulWidget {
  const RankScreen({super.key});

  @override
  State<RankScreen> createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen> {
  static const List<String> tabList = ['술', '술+안주'];

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: TopActionBar(
          action: ActionType.notice,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '이번주 랭킹',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Dark.gray900,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      child: Text(
                        // TODO: 날짜 변경
                        '12/04 ~ 12/10',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Dark.gray600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SulTabBar(tabList: tabList),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: Text('술 탭'),
                    ),
                    Center(
                      child: Text('술+안주 탭'),
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
