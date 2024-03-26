import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_feed/Utilities/globals.dart';

import '../models/article.dart';

class Pref {
  static RxList<Article> savedNewsList = <Article>[].obs; // Use RxList
  static RxList<Article> generalList = <Article>[].obs; // Use RxList
  static RxList<Article> categoryWiseList = <Article>[].obs;
  static RxList<Article> trendingList = <Article>[].obs;
  static RxList<Article> topStoriesList = <Article>[].obs;
  static RxList<String> searchesList = <String>[].obs;
  static RxMap<String, bool> categoryFilterList = {
    "India": false,
    "Fashion": false,
    "Business": false,
    "Politics": false,
    "International": false,
    "Travel": false,
    "Education": false,
  }.obs;
  static late Box _box;

  static Future<void> initializeHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('data');
  }

  static String getString(String key, String defaultValue) {
    return _box.get(key) ?? defaultValue;
  }

  static void setString(String key, String value) {
    _box.put(key, value);
  }

  static int getInt(String key, int defaultValue) {
    return _box.get(key) ?? defaultValue;
  }

  static void setInt(String key, int value) {
    _box.put(key, value);
  }

  static bool getBool(String key, bool defaultValue) {
    return _box.get(key) ?? defaultValue;
  }

  static void setBool(String key, bool value) {
    _box.put(key, value);
  }

  static setArticlesList(String key, List<Article> v) {
    _box.put('articles$key', jsonEncode(v));
    savedNewsList.assignAll(v);
  }

  static List<Article> getArticleList(String key) {
    List<Article> temp = [];
    final data = jsonDecode(_box.get('articles$key') ?? '[]');
    for (var i in data) {
      temp.add(Article.fromJson(i));
    }
    return temp;
  }

  static bool checkArticleSaved(String title) {
    final List<Article> list = savedNewsList;

    bool found = false;

    for (int i = 0; i < list.length; i++) {
      if (list[i].title == title) {
        found = true;
        break;
      }
    }
    return found;
  }

  static void removeFromSaved(Article article) {
    savedNewsList
        .removeWhere((savedArticle) => savedArticle.title == article.title);
    final List<Article> list = savedNewsList.toList(); // Convert RxList to List
    Pref.setArticlesList(savedNewsListKey, list);
  }

  static void addToSaved(Article article) {
    savedNewsList.add(article);
    final List<Article> list = savedNewsList.toList(); // Convert RxList to List
    Pref.setArticlesList(savedNewsListKey, list);
  }

  static setSearchesList(String key, List<String> v) {
    _box.put('searches$key', jsonEncode(v));
    searchesList.assignAll(v);
  }

  static List<String> getSearchesList(String key) {
    List<String> temp = [];
    final data = jsonDecode(_box.get('searches$key') ?? '[]');
    for (var i in data) {
      temp.add(i);
    }
    return temp;
  }

  static bool checkSearchesSaved(String title) {
    final List<String> list = searchesList;

    bool found = false;

    for (int i = 0; i < list.length; i++) {
      if (list[i] == title) {
        found = true;
        break;
      }
    }
    return found;
  }

  static void removeFromSearches() {
    searchesList.clear();
    final List<String> list = searchesList.toList(); // Convert RxList to List
    Pref.setSearchesList(searchedListKey, list);
  }

  static void addToSearches(String article) {
    searchesList.add(article);
    final List<String> list = searchesList.toList(); // Convert RxList to List
    Pref.setSearchesList(searchedListKey, list);
  }
}
