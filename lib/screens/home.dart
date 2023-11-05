import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/providers/count.dart';

import 'package:sul_sul/widgets/header.dart';

import 'package:sul_sul/utils/auth/login_google.dart';

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
              ElevatedButton(
                onPressed: () => loginByGoogle(),
                child: const Text('Sign in with Google'),
              ),
              ElevatedButton(
                onPressed: () => logoutByGoogle(),
                child: const Text('Sign out with Google'),
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
