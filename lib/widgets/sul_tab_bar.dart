import 'package:flutter/material.dart';
import 'package:sul_sul/theme/colors.dart';

class SulTabBar extends StatefulWidget {
  final List<String> tabList;

  const SulTabBar({super.key, required this.tabList});

  @override
  State<SulTabBar> createState() => _SulTabBarState();
}

class _SulTabBarState extends State<SulTabBar> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        for (var tab in widget.tabList) Tab(text: tab),
      ],
      indicatorColor: Main.main,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Dark.gray300,
      dividerHeight: 1,
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      labelColor: Main.main,
      unselectedLabelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelColor: Dark.gray300,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          return Colors.transparent;
        },
      ),
    );
  }
}
