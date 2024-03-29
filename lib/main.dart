import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

import 'package:sul_sul/providers/nickname_provider.dart';
import 'package:sul_sul/providers/pairings_provider.dart';
import 'package:sul_sul/providers/main_provider.dart';
import 'package:sul_sul/providers/user_provider.dart';

import 'package:sul_sul/screens/main.dart';
import 'package:sul_sul/utils/auth/secrets.dart';

void main() {
  KakaoSdk.init(nativeAppKey: kakaoNativeAppKey);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NicknameProvider()),
        ChangeNotifierProvider(create: (_) => PairingsProvider()),
        ChangeNotifierProvider(create: (_) => MainProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
