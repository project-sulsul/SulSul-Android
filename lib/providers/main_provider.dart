import 'package:flutter/material.dart';

class MainProvider with ChangeNotifier {
  int _screenIndex = 0;

  int get screenIndex => _screenIndex;

  void navigate(int index) {
    _screenIndex = index;
    notifyListeners();
  }
}
