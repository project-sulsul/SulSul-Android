import 'package:shared_preferences/shared_preferences.dart';

Future<List<String>> getRecentSearchList({required String key}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? items = prefs.getStringList(key);

  return items ?? [];
}

Future<void> setRecentSearchList({
  required List<String> list,
  required String value,
  required String key,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (list.contains(value)) {
    prefs.setStringList(
        key, [value, ...list.where((search) => search != value).toList()]);
    return;
  }

  var newlist = [value, ...list];
  prefs.setStringList(
      key, newlist.length > 5 ? newlist.sublist(0, 5) : newlist);
}

Future<List<String>> removeRecentSerarch({
  required List<String> list,
  required String value,
  required String key,
}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (value == 'all') {
    await prefs.remove(key);
    return [];
  }

  prefs.setStringList(key, list.where((search) => search != value).toList());
  return await getRecentSearchList(key: key);
}
