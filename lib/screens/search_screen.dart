import 'package:flutter/material.dart';

import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/button.dart';
import 'package:sul_sul/widgets/top_action_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  PreferenceRepository preferenceRepository =
      PreferenceRepository(apiClient: sulsulServer);

  List<String> recentSearchList = [];
  List<PreferenceResponse> alcoholList = [];
  List<PreferenceResponse> foodList = [];
  List<PreferenceResponse> searchedAlcoholList = [];
  List<PreferenceResponse> searchedFoodList = [];
  bool isSearched = false;

  @override
  void initState() {
    super.initState();

    // TODO: 최근 검색어 불러오기 (client)
    setState(() {
    recentSearchList = ['최근 검색어', '최근 검색어 긴거', '최근 검색어 내용긴거', '짧은 검색어'];
    });
    _getPreferenceList();
  }

  void _getPreferenceList() async {
    var response = await preferenceRepository.getPreferenceList(Pairings.all);

    setState(() {
      alcoholList =
          response?.where((res) => res.type == Pairings.alcohol).toList() ?? [];
      foodList =
          response?.where((res) => res.type == Pairings.food).toList() ?? [];
    });
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      searchedAlcoholList = [];
      searchedFoodList = [];
      isSearched = false;
    });
  }

  void _removeRecentSearch() {
    // TODO: 최근 검색어 삭제
    print('remove');
  }

  void _onSearch(String value) {
    var searchedAlcoholList =
        alcoholList.where((food) => food.name.contains(value)).toList();
    var searchedFoodList =
        foodList.where((food) => food.name.contains(value)).toList();

    // TODO: 최근 검색어 수정

    setState(() {
      _controller.text = value;
      searchedAlcoholList = searchedAlcoholList;
      searchedFoodList = searchedFoodList;
      isSearched = true;
    });
    // TODO: 검색
    print(value);
  }

  Widget _searchBar() {
    // TODO: 공통 위젯 교체
    return TextFormField(
      controller: _controller,
      cursorColor: Dark.gray900,
      style: const TextStyle(
        color: Dark.gray900,
        fontWeight: FontWeight.bold,
        fontSize: 32,
        decorationThickness: 0,
      ),
      textInputAction: TextInputAction.go,
      onFieldSubmitted: _onSearch,
      decoration: InputDecoration(
        hintText: '검색어를 입력해주세요',
        hintStyle: const TextStyle(color: Dark.gray200),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        suffixIcon: _controller.text.isNotEmpty
            ? IconButton(
                onPressed: _clearSearch,
                icon: const Icon(
                  CustomIcons.cancel_rounded_filled,
                  color: Dark.gray400,
                ),
                iconSize: 22,
              )
            : null,
      ),
    );
  }

  Widget _recentSearches() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '최근 검색어',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Dark.gray700,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
              ),
              onPressed: () {},
              child: const Text(
                '모두 삭제',
                style: TextStyle(
                  color: Dark.gray700,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Wrap(
          spacing: 16,
          children: [
            for (var search in recentSearchList)
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Button(
                  title: search,
                      onPressed: () => _onSearch(search),
                  rightIcon: CustomIcons.cancel_rounded_filled,
                  iconColor: Dark.gray400,
                  onIconPressed: _removeRecentSearch,
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                    left: 14,
                    right: 6,
                  ),
                ),
              ),
          ],
        ),
      ],
        ),
      ),
    );
  }

  Widget _searchResults({
    required List<PreferenceResponse> results,
    required String target,
  }) {
    return Container(
    );
  }

  Widget _searches() {
    return SingleChildScrollView(
      child: Column(
        children: [
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopActionBar(
        title: '검색',
        type: ActionBarType.back,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 14,
            ),
            child: _searchBar(),
          ),
          const Divider(
            thickness: 2,
            height: 0,
            color: Dark.gray100,
          ),
          Expanded(
            child: !isSearched ? _recentSearches() : _searches(),
          ),
        ],
      ),
    );
  }
}
