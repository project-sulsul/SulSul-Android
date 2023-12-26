import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class GNB extends StatefulWidget {
  const GNB({super.key});

  @override
  State<GNB> createState() => _GNBState();
}

class _GNBState extends State<GNB> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Index 0: 홈', style: optionStyle),
    Text('Index 1: 랭킹', style: optionStyle),
    Text('Index 2: 새 피드 작성', style: optionStyle),
    Text('Index 2: 피드', style: optionStyle),
    Text('Index 2: 마이페이지', style: optionStyle),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  //TODO: 아이콘 변경
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: '랭킹',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: '새 피드 작성',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: '피드',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: '마이페이지',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Main.main,
      onTap: _onItemTapped,
    );
  }
}