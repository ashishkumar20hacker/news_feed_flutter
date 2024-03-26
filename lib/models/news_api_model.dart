import 'dart:convert';

import 'package:news_feed/Utilities/globals.dart';
import 'package:news_feed/models/article.dart';
import 'package:http/http.dart' as http;

class NewsApiModel {
  String? status;
  int? totalResults;
  List<Article?>? articles;

  NewsApiModel({this.status, this.totalResults, this.articles});

  NewsApiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <Article>[];
      json['articles'].forEach((v) {
        articles!.add(Article.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalResults'] = totalResults;
    data['articles'] = articles?.map((v) => v?.toJson()).toList();
    return data;
  }
}

Future<List<Article>> fetchData(String query, String sortBy) async {
  // Get yesterday's date
  DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));

  // Form the URL
  String url =
      "${baseUrl}q=$query&from=${yesterday.toString().split(' ')[0]}&to=${yesterday.toString().split(' ')[0]}&sortBy=$sortBy&apiKey=$apiKey";

  // Make the HTTP request
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    List<Article> articles = [];
    var jsonData = jsonDecode(response.body);
    if (jsonData['articles'] != null) {
      for (var item in jsonData['articles']) {
        var article = Article.fromJson(item);
        if (article.title != "[Removed]") {
          articles.add(article);
        }
      }
    }
    return articles;
  } else {
    // If the server did not return a 200 OK response,
    // throw an exception.
    throw Exception('Failed to load data');
  }
}
