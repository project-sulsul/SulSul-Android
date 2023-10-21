import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/providers/count.dart';

import 'package:sul_sul/screens/main.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
      ],
      child: const MyApp()
    ),
  );
}