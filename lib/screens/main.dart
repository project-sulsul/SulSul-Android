import 'package:flutter/material.dart';

import 'package:sul_sul/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sul Sul',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      routes: routes,
    );
  }
}

final routes = {
  '/home': (context) => const HomeScreen(),
  '/sign-in': (context) => const HomeScreen(),
  '/preference': (context) => const HomeScreen(),
};
