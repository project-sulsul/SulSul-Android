import 'package:flutter/material.dart';

import 'package:sul_sul/screens/home_screen.dart';
import 'package:sul_sul/screens/my_page_screen.dart';
import 'package:sul_sul/utils/constants.dart';

import 'package:sul_sul/widgets/gnb.dart';
import 'package:sul_sul/widgets/top_action_bar.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text('랭킹 화면을 추가해주세요.'),
    Text('새 피드 작성 화면을 추가해주세요.'),
    Text('피드 화면을 추가해주세요.'),
    MyPageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopActionBar(
        type: ActionBarType.none,
        action: ActionType.notice,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: GNB(
          index: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
