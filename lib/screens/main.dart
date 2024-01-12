import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/screens/sign_in_screen.dart';
import 'package:sul_sul/screens/update_nickname_screen.dart';
import 'package:sul_sul/screens/home_screen.dart';

import 'package:sul_sul/widgets/header.dart';

import 'package:sul_sul/widgets/gnb.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text('랭킹 화면을 추가해주세요.'),
    Text('새 피드 작성 화면을 추가해주세요.'),
    Text('피드 화면을 추가해주세요.'),
    Text('마이페이지 화면을 추가해주세요.'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sul Sul',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Dark.black,
          iconTheme: IconThemeData(color: Dark.white),
          titleTextStyle: TextStyle(color: Dark.white),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Dark.gray900,
            fontSize: 15,
          ),
        ),
        scaffoldBackgroundColor: Dark.black,
        useMaterial3: true,
        fontFamily: 'Pretendard',
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: const Header(title: '술이 술술'),
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
      ),
      routes: routes,
    );
  }
}

final routes = {
  '/sign-in': (context) => const SignInScreen(),
  '/home': (context) => const HomeScreen(),
  '/update-nickname': (context) => const UpdateNicknameScreen(),
};
