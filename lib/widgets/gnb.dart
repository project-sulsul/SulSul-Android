import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

class GNB extends StatefulWidget {
  const GNB({super.key});

  @override
  State<GNB> createState() => _GNBState();
}

class _GNBState extends State<GNB> {
  //TODO: 아이콘 변경
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Dark.black,
      child: const SizedBox(
        child: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home_outlined), text: '홈'),
            Tab(icon: Icon(Icons.bar_chart_outlined), text: '랭킹'),
            Tab(icon: Icon(Icons.add_circle_outline), text: '새 피드 작성'),
            Tab(icon: Icon(Icons.feed_outlined), text: '피드'),
            Tab(icon: Icon(Icons.account_circle_outlined), text: '마이페이지'),
          ],
          indicatorColor: Colors.transparent,
          dividerHeight: 0,
          labelColor: Main.main,
          labelStyle: TextStyle(fontSize: 10),
          unselectedLabelColor: Dark.gray400,
        ),
      ),
    );
  }
}

// class _GNBState extends State<GNB> {
//   int _selectedIndex = 0;
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     HomeScreen(),
//     RankScreen(),
//     CreateFeedScreen(),
//     FeedScreen(),
//     MyPageScreen(),
//   ];
//
//   static const List<String> pathnames = <String>[
//     '/home',
//     '/rank',
//     '/feed',
//     '/my-page'
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     Navigator.pushNamed(context, pathnames[index]);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       currentIndex: _selectedIndex,
//       unselectedItemColor: Dark.gray400,
//       selectedItemColor: Main.main,
//       showUnselectedLabels: true,
//       unselectedLabelStyle: const TextStyle(color: Dark.gray400),
//       selectedFontSize: 10,
//       unselectedFontSize: 10,
//       onTap: _onItemTapped,
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home_outlined),
//           activeIcon: Icon(Icons.home),
//           backgroundColor: Dark.black,
//           label: '홈',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.bar_chart_outlined),
//           activeIcon: Icon(Icons.bar_chart_rounded),
//           backgroundColor: Dark.black,
//           label: '랭킹',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.add_circle_outline),
//           backgroundColor: Dark.black,
//           activeIcon: Icon(Icons.add_circle_rounded),
//           label: '새 피드 작성',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.feed_outlined),
//           backgroundColor: Dark.black,
//           activeIcon: Icon(Icons.feed_rounded),
//           label: '피드',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.account_circle_outlined),
//           backgroundColor: Dark.black,
//           activeIcon: Icon(Icons.account_circle_rounded),
//           label: '마이페이지',
//         ),
//       ],
//     );
//   }
// }
