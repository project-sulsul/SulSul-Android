import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';

class PairingsProvider with ChangeNotifier {
  String _selectedAlcohol = '';
  Set<String> _alcoholCategory = {};
  Set<String> _foodCategory = {};
  List<PreferenceResponse> _alcoholList = [];
  List<PreferenceResponse> _foodList = [];

  String get selectedAlcohol => _selectedAlcohol;
  Set<String> get alcoholCategory => _alcoholCategory;
  Set<String> get foodCategory => _foodCategory;
  List<PreferenceResponse> get alcoholList => _alcoholList;
  List<PreferenceResponse> get foodList => _foodList;

  final PreferenceRepository _preferenceRepository =
      PreferenceRepository(apiClient: sulsulServer);

  void selectAlcohol(String alcohol) {
    _selectedAlcohol = alcohol;
    notifyListeners();
  }

  Future<void> getPairList() async {
    try {
      var pairList =
          await _preferenceRepository.getPreferenceList(Pairings.all) ?? [];
      _alcoholList =
          pairList.where((pair) => pair.type == Pairings.alcohol).toList();
      _foodList = pairList.where((pair) => pair.type == Pairings.food).toList();

      _alcoholCategory = {for (var alcohol in _alcoholList) alcohol.subtype};
      _foodCategory = {for (var food in _foodList) food.subtype};

      _selectedAlcohol = _alcoholCategory.toList()[0];

      notifyListeners();
    } catch (error) {
      log("랜덤 닉네임 호출 실패 :: $error");
    }
  }
}
