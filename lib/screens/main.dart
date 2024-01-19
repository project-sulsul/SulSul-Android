import 'package:flutter/material.dart';

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
      home: const DefaultScreen(),
      routes: routes,
    );
  }
}

final routes = {
  '/sign-in': (context) => const SignInScreen(),
  '/update-nickname': (context) => const UpdateNicknameScreen(),
  '/preference-alcohol': (context) => const PreferenceAlcoholScreen(),
};
