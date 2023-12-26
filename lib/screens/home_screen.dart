import 'package:flutter/material.dart';

import 'package:sul_sul/widgets/header.dart';
import 'package:sul_sul/widgets/gnb.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Header(title: '술이 술술'),
      body: Text('Home'),
      bottomNavigationBar: GNB(),
    );
  }
}
