
// import 'dart:developer';

// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:news_feed/Utilities/globals.dart';
// import 'package:news_feed/Utilities/pref.dart';
// import 'package:news_feed/models/article.dart';

// class HiveService {
//   static RxList<Article> savedNewsList = <Article>[].obs; // Use RxList
//   static Future<void> initHive() async {
//     await Hive.initFlutter();
//     // Open boxes for each type of data
//     await Hive.openBox<String>('strings');
//     await Hive.openBox<int>('ints');
//     await Hive.openBox<bool>('booleans');
//     await Hive.openBox<Article>('articles');
//     await Hive.openBox<List<String>>('lists');
//   }

//   static Future<void> putString(String key, String value) async {
//     final box = await Hive.openBox<String>('strings');
//     await box.put(key, value);
//   }

//   static String? getString(String key) {
//     final box = Hive.box<String>('strings');
//     return box.get(key, defaultValue: "");
//   }

//   static Future<void> putInt(String key, int value) async {
//     final box = await Hive.openBox<int>('ints');
//     await box.put(key, value);
//   }

//   static int? getInt(String key, int defaultValue) {
//     final box = Hive.box<int>('ints');
//     return box.get(key, defaultValue: defaultValue);
//   }

//   static Future<void> putBoolean(String key, bool value) async {
//     final box = await Hive.openBox<bool>('booleans');
//     await box.put(key, value);
//   }

//   static bool? getBoolean(String key, bool defaultValue) {
//     final box = Hive.box<bool>('booleans');
//     return box.get(key, defaultValue: defaultValue);
//   }

//   // static Future<void> putArticleList(List<Article> list) async {
//   //   final box = await Hive.openBox<Article>('articles');
//   //   box.put(savedNewsListKey, jsonEncode(list) as Article);
//   //   savedNewsList.assignAll(list); // Assign list to RxList
//   // }

//   // static List<Article> getArticleList() {
//   //   final box = Hive.box<Article>('articles');
//   //   List<Article> temp = [];
//   //   final data = jsonDecode(box.get(savedNewsListKey,Article()));
//   //   for (var i in data) {
//   //     temp.add(Article.fromJson(i));
//   //   }
//   //   return temp;
//   // }

//   static Future<void> putStringList(String key, List<String> list) async {
//     final box = await Hive.openBox<List<String>>('lists');
//     await box.put(key, list);
//   }

//   static List<String>? getStringList(String key) {
//     final box = Hive.box<List<String>>('lists');
//     return box.get(key, defaultValue: []);
//   }

//   static Future<void> clearStringList(String key) async {
//     final box = await Hive.openBox<List<String>>('lists');
//     await box.put(key, []);
//   }

//   static Future<void> putSearchedDataList(List<String> list) async {
//     await putStringList(searchedList, list);
//   }

//   static List<String>? getSearchedDataList() {
//     return getStringList(searchedList);
//   }

//   static Future<void> makeSearchedDataListEmpty() async {
//     await clearStringList(searchedList);
//   }

//   static bool checkArticleSaved(String title) {
//     final List<Article> list = savedNewsList;

//     bool found = false;

//     for (int i = 0; i < list.length; i++) {
//       if (list[i].title == title) {
//         found = true;
//         break;
//       }
//     }
//     return found;
//   }

//   // Other methods remain unchanged

//   static void removeFromSaved(Article article) {
//     savedNewsList
//         .removeWhere((savedArticle) => savedArticle.title == article.title);
//     final List<Article> list = savedNewsList.toList(); // Convert RxList to List
//     Pref.setArticlesList(savedNewsListKey, list);
//     log("Article: ${Pref.getArticleList(savedNewsListKey)}");
//   }

//   static void addToSaved(Article article) {
//     savedNewsList.add(article);
//     final List<Article> list = savedNewsList.toList(); // Convert RxList to List
//     Pref.setArticlesList(savedNewsListKey, list);
//     log("Article: ${Pref.getArticleList(savedNewsListKey)}");
//   }
// }
