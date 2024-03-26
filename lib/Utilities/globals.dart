import 'package:flutter/material.dart';

const String appName = 'News Feed';
const String packageName = 'com.example.news_feed';
const String assetImagePath = 'assets/images/';
const String assetGifPath = 'assets/gifs/';
const String isFirstRun = 'isFirstRun';
const String savedNewsListKey = 'savedNewsListKey';
String radioButtonValue = '';
const String checkBoxValue = '';
const String searchedListKey = 'searchedListKey';
const String baseUrl = "https://newsapi.org/v2/everything?";
const String apiKey = "080a9ed610fb4ba48c374243e9481970";

const Color blue = Color(0xFF0F4DDE);
const Color unselectedBtm = Color(0x40000000);
const Color unselectedCd = Color(0xFFF6F6F6);

const MaterialColor white = MaterialColor(
  0xFFFFFFFF,
  <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFFFFF),
    300: Color(0xFFFFFFFF),
    400: Color(0xFFFFFFFF),
    500: Color(0xFFFFFFFF),
    600: Color(0xFFFFFFFF),
    700: Color(0xFFFFFFFF),
    800: Color(0xFFFFFFFF),
    900: Color(0xFFFFFFFF),
  },
);

 String replaceTextFromPosition(String text) {
  String delimiter = "[+";
  int index = text.indexOf(delimiter);
  if (index != -1) {
    return text.substring(0, index);
  }
  return text;
}

