import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

import 'package:sul_sul/models/preference_model.dart';
import 'package:sul_sul/models/preference_repository.dart';
import 'package:sul_sul/utils/storage.dart';
import 'package:sul_sul/utils/api/api_client.dart';

import 'package:sul_sul/utils/constants.dart';
import 'package:sul_sul/utils/constants/key.dart';
import 'package:sul_sul/theme/custom_icons_icons.dart';
import 'package:sul_sul/theme/colors.dart';

import 'package:sul_sul/widgets/top_action_bar.dart';
import 'package:sul_sul/widgets/search/result_list.dart';
import 'package:sul_sul/widgets/button.dart';

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
  String word = '';

  @override
  void initState() {
    super.initState();

    _getRecentSearchList();
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

  void _getRecentSearchList() async {
    var searches = await getRecentSearchList(key: recentSearches);

    setState(() {
      recentSearchList = searches;
    });
  }

  void _setRecentSearchList(String value) async {
    await setRecentSearchList(
      list: recentSearchList,
      value: value,
      key: recentSearches,
    );
  }

  void _removeRecentSearch(String value) async {
    var searches = await removeRecentSerarch(
      list: recentSearchList,
      value: value,
      key: recentSearches,
    );

    setState(() {
      recentSearchList = searches;
    });
  }

  void _onChangeValue(String value) {
    setState(() {});
  }

  void _clearSearch() {
    setState(() {
      _controller.clear();
      searchedAlcoholList = [];
      searchedFoodList = [];
      word = '';
    });

    _getRecentSearchList();
  }

  void _onSearch(String value) async {
    var newAlcoholList =
        alcoholList.where((alcohol) => alcohol.name.contains(value)).toList();
    var newFoodList =
        foodList.where((food) => food.name.contains(value)).toList();

    setState(() {
      _controller.text = value;
      word = value;
      searchedAlcoholList = newAlcoholList;
      searchedFoodList = newFoodList;
    });

    _setRecentSearchList(value);
  }

  Widget _searchBar() {
    // TODO: 공통 위젯 교체
    return TextFormField(
      controller: _controller,
      cursorColor: Dark.gray900,
      onChanged: _onChangeValue,
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
    if (recentSearchList.isEmpty) return Container();

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
                  onPressed: () => _removeRecentSearch('all'),
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
                      onIconPressed: () => _removeRecentSearch(search),
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

  Widget _searches() {
    if (searchedAlcoholList.isEmpty && searchedFoodList.isEmpty) {
      return Center(
        child: EasyRichText(
          '"$word"의\n검색결과가 없어요',
          defaultStyle: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Dark.gray600),
          patternList: [
            EasyRichTextPattern(
              targetString: '"$word"',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Main.main,
              ),
            ),
          ],
          textAlign: TextAlign.center,
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (searchedAlcoholList.isNotEmpty)
            ResultList(
              results: searchedAlcoholList,
              target: Pairings.alcohol,
              // TODO: 상세 화면 이동
              onTap: () {},
            ),
          if (searchedAlcoholList.isNotEmpty && searchedFoodList.isNotEmpty)
            const Divider(
              thickness: 10,
              color: Dark.gray100,
            ),
          if (searchedFoodList.isNotEmpty)
            ResultList(
              results: searchedFoodList,
              target: Pairings.food,
              // TODO: 상세 화면 이동
              onTap: () {},
            ),
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
            child: word == '' ? _recentSearches() : _searches(),
          ),
        ],
      ),
    );
  }
}
