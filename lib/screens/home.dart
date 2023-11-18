import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/providers/count.dart';
import 'package:sul_sul/utils/auth/login_kakao.dart';

import 'package:sul_sul/widgets/header.dart';

import 'package:sul_sul/utils/auth/login_google.dart';
import 'package:sul_sul/widgets/image_ink_well.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final count = context.watch<Counter>().count;

    return Scaffold(
      appBar: const Header(title: '술이 술술'),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => Counter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$count',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const ImageInkWell(
                  text: '카카오로 계속하기',
                  color: Colors.yellow,
                  iconPath: 'assets/images/kakao_icon.png',
                  onTap: loginByKakao),
              const ImageInkWell(
                  text: 'Google로 계속하기',
                  color: Colors.white,
                  iconPath: 'assets/images/google_icon.png',
                  onTap: loginByGoogle),
              ElevatedButton(
                onPressed: () => logoutByGoogle(),
                child: const Text('구글 로그아웃'),
              ),
              ElevatedButton(
                onPressed: () => logoutByKakao(),
                child: const Text('카카오 로그아웃'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<Counter>().increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
