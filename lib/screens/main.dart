import 'package:flutter/material.dart';

import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/screens/sign_in_screen.dart';
import 'package:sul_sul/screens/update_nickname_screen.dart';
import 'package:sul_sul/screens/layout.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sul Sul',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
        fontFamily: 'Pretendard',
      ),
      home: const SignInScreen(),
      routes: routes,
    );
  }
}

final routes = {
  '/home': (context) => const Layout(),
  '/sign-in': (context) => const SignInScreen(),
  '/update-nickname': (context) => const UpdateNicknameScreen(),
};
