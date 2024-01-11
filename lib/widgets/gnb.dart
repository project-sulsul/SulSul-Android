import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';

class GNB extends StatelessWidget {
  final int index;
  final void Function(int) onTap;

  const GNB({super.key, required this.index, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border:
            Border(top: BorderSide(color: Dark.gray100, width: 1.0)), // 라인효과
      ),
      child: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Dark.black,
        selectedItemColor: Main.main,
        unselectedItemColor: Dark.gray400,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 30,
        onTap: onTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.home_outlined),
            activeIcon: Icon(CustomIcons.home_filled),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.rank_outlined),
            activeIcon: Icon(CustomIcons.rank_filled),
            label: '랭킹',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.add_rounded_outlined),
            activeIcon: Icon(CustomIcons.add_rounded_filled),
            label: '새 피드 작성',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.feed_outlined),
            activeIcon: Icon(CustomIcons.feed_filled),
            label: '피드',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.profile_outlined),
            activeIcon: Icon(CustomIcons.profile_filled),
            label: '마이페이지',
          ),
        ],
      ),
    );
  }
}
