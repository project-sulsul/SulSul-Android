import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/providers/pairings_provider.dart';

import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/screens/sign_in_screen.dart';
import 'package:sul_sul/screens/update_nickname_screen.dart';
import 'package:sul_sul/screens/default_screen.dart';
import 'package:sul_sul/screens/preference/food_screen.dart';
import 'package:sul_sul/screens/preference/alcohol_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _getPairList();
    _getUserData();
    super.initState();
  }

  void _getPairList() async {
    final provider = Provider.of<PairingsProvider>(context, listen: false);
    await provider.getPairList();
  }

  // TODO: 유저 데이터 저장
  void _getUserData() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sul Sul',
      theme: ThemeData(
        canvasColor: Colors.transparent,
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
      home: const DefaultScreen(),
      routes: routes,
    );
  }
}

final routes = {
  '/sign-in': (context) => const SignInScreen(),
  '/update-nickname': (context) => const UpdateNicknameScreen(),
  '/preference-alcohol': (context) => const PreferenceAlcoholScreen(),
  '/preference-food': (context) => const PreferenceFoodScreen(),
};
