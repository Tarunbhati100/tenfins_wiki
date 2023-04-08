import 'dart:io';
import 'package:hive/hive.dart';
import 'package:sync_program/api/api.dart';
import 'package:sync_program/api/api_local.dart';
import 'package:sync_program/api/api_remote.dart';
import 'package:sync_program/src/sync_program_base.dart';

class App {
  final Api _apilocal = ApiLocal();
  final Api _apiRemote = ApiRemote();

  Future hiveInit() async {
    var path = Directory.current.path;
    Hive.init(path);

    // Hive.registerAdapter<Articlemodel>(ArticlemodelAdapter());
    await Hive.openBox("tbl_article_local_box");
    await Hive.openBox("tbl_article_changelog_box");
    await Hive.openBox("tbl_article_remote");
  }

  Future getArticleList(connectivityStatus) async {
    if (connectivityStatus) {
      final articleList = await _apiRemote.getArticleList();
      for (var element in articleList) {
        print("article list with internet : $element");
        await SyncData().syncRemoteToLocal(element);
      }
    } else {
      final articleList = await _apilocal.getArticleList();
      for (var element in articleList) {
        print("article list with internet : $element");
      }
    }
  }

  Future searchArticleList(connectivityStatus) async {
    if (connectivityStatus) {
      final articleList = await _apiRemote.searchArticleList("");
      print("Availabe internet ArticleList Search : $articleList");
    } else {
      final articleList = await _apilocal.searchArticleList("");
      print("No internet ArticleList search : $articleList");
    }
  }

  Future getCategoryList(connectivityStatus) async {
    if (connectivityStatus) {
      final category = await _apiRemote.getCategoryList();
      print("Availabe internet category : $category");
    } else {
      final category = await _apilocal.getCategoryList();
      print("No internet category : $category");
    }
  }

  Future getTypeList(connectivityStatus) async {
    if (connectivityStatus) {
      final type = await _apiRemote.getTypeList();
      print("Availabe internet type : $type");
    } else {
      final type = await _apilocal.getTypeList();
      print("No internet type : $type");
    }
  }

  Future<void> updateArticle(connectivityStatus) async {
    if (connectivityStatus) {
      String uuid = "0ea10fa0-d536-11ed-a28e-49dabf5c511f";
      await _apiRemote.updateArticle(uuid);
    } else {
      String uuid = "0ea10fa0-d536-11ed-a28e-49dabf5c511f";
      await _apilocal.updateArticle(uuid);
    }
  }

  Future<void> saveArticle(connectivityStatus) async {
    if (connectivityStatus) {
      await _apiRemote.saveArticle();
    } else {
      await _apilocal.saveArticle();
    }
  }

  Future deleteArticle(connectivityStatus) async {
    if (connectivityStatus) {
      final article = await _apiRemote.deleteArticle();
      return article;
    } else {
      final article = await _apilocal.deleteArticle();
      return article;
    }
  }
//TODO: define proper sync logic
  Future syncData() async {
    await SyncData().syncData();
  }
}
