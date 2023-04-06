// ignore_for_file: unused_field, avoid_print, file_names
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:sync_program/common/component.dart';
import 'package:sync_program/models/databaseModel.dart';

abstract class ApiBase {}

class ApiLocal extends ApiBase {
  Future getArticleList() async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    List articleList = box.values.toList();
    if (articleList.isEmpty) {
      return [];
    }
    return articleList;
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

  Future<List> getCategoryList() async {
    return articleCategory;
  }

  Future<List> getTypeList() async {
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

class ApiRemote extends ApiBase {
  Future<List> getArticleList() async {
    return articleList;
  }

  Future searchArticleList(value) async {
    return articleList;
  }

  Future<List> getCategoryList() async {
    return articleCategory;
  }

  Future<List> getTypeList() async {
    return typeCategory;
  }

  Future<void> saveArticle() async {}

  Future<void> updateArticle() async {}

  Future<void> deleteArticle() async {}
}

class SyncData extends ApiBase {
  //------------- Sync Remote To Local Data --------------------------//
  Future<void> syncRemoteToLocalData(articlelist) async {
    print("Sync Remote To Local Data");
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    for (Articlemodel value in articlelist) {
      final article = Articlemodel()
        ..id = 1
        ..title = value.title
        ..shortdescription = value.shortdescription
        ..category = value.category
        ..keywords = value.keywords
        ..author = value.author
        ..views = value.views
        ..likes = value.likes
        ..mentions = value.mentions
        ..stars = value.stars
        ..tags = value.tags
        ..type = value.type
        ..lastUpdated = value.lastUpdated
        ..dateTime = value.dateTime
        ..content = value.content;
      await box.add(article);
      article.save();
    }
  }
  //----------------------- End --------------------------//
}
