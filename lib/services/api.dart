// ignore_for_file: unused_field, avoid_print

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';

abstract class ApiBase {
  Future<List> getArticleCategoryList();
}

class JsonApi extends ApiBase {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  Future getArticleList() async {
    var result = await _connectivity.checkConnectivity();
    print("resultresult : $result");
    if (result == ConnectivityResult.none) {
      print("ConnectivityResult : No Internet");
      Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
      List articleList = box.values.toList();
      if (articleList.isEmpty) {
        return [];
      }
      return articleList;
    } else {
      print("ConnectivityResult : Yes Internet");
      Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
      List articleList = box.values.toList();
      if (articleList.isEmpty) {
        return [];
      }
      return articleList;
    }
  }

  Future searchArticleList(value) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    List articleList = box.values
        .where((c) => c.title!.toLowerCase().contains(value))
        .toList();
    if (articleList.isEmpty) {
      return [];
    }
    return articleList;
  }

  @override
  Future<List> getArticleCategoryList() async {
    List articleCategory = [
      {"id": 0, "categoryname": "Motivation"},
      {"id": 1, "categoryname": "Life Lessons"},
      {"id": 3, "categoryname": "Creativity"},
      {"id": 4, "categoryname": "Habits"},
      {"id": 5, "categoryname": "Focus"},
      {"id": 6, "categoryname": "Productivity"},
    ];
    return articleCategory;
  }

  Future<List> getArticleTypeList() async {
    List typeCategory = [
      {"id": 0, "title": "InActive"},
      {"id": 1, "title": "Active"},
    ];
    return typeCategory;
  }

  Future<void> saveArticle(Articlemodel article) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.add(article);
    article.save();
  }

  Future<void> updateArticle(Articlemodel updateArticle, index) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.putAt(index, updateArticle);
  }

  Future<void> deleteArticle(index) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.deleteAt(index);
  }
}
