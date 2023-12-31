import 'package:flutter/material.dart';

import 'package:sul_sul/screens/home_screen.dart';

import 'package:sul_sul/widgets/header.dart';
import 'package:sul_sul/widgets/gnb.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: Header(title: '술이 술술'),
        body: TabBarView(
            // TODO: add screens
            children: [
              HomeScreen(),
              Text('랭킹'),
              Text('새 피드 작성'),
              Text('피드'),
              Text('마이페이지'),
            ]),
        bottomNavigationBar: GNB(),
      ),
    );
  }
}
