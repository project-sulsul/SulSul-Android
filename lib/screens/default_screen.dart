import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/providers/main_provider.dart';

import 'package:sul_sul/screens/home_screen.dart';
import 'package:sul_sul/screens/my_page_screen.dart';
import 'package:sul_sul/screens/rank_screen.dart';

import 'package:sul_sul/widgets/gnb.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({super.key});

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    RankScreen(),
    Text('새 피드 작성 화면을 추가해주세요.'),
    Text('피드 화면을 추가해주세요.'),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int screenIndex = context.watch<MainProvider>().screenIndex;

    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(screenIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: GNB(
          index: screenIndex,
          onTap: context.read<MainProvider>().navigate,
        ),
      ),
    );
  }
}
