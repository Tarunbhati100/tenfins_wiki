import 'dart:io';
import 'package:sync_program/sync_program.dart';
import 'package:hive/hive.dart';

void main() async {
  var path = Directory.current.path;
  Hive.init(path);

  // Hive.registerAdapter<Articlemodel>(ArticlemodelAdapter());
  await Hive.openBox("tbl_article_local_box");
  await Hive.openBox("tbl_article_changelog_box");
  await Hive.openBox("tbl_article_remote");
  bool connectivityStatus = false;

  // saveArticle(connectivityStatus);
  updateArticle(connectivityStatus);
  getArticleList(connectivityStatus);

  syncData();
  // deleteArticle(connectivityStatus);
  // searchArticleList(connectivityStatus);
  // getCategoryList(connectivityStatus);
  // getTypeList(connectivityStatus);
}

Future getArticleList(connectivityStatus) async {
  if (connectivityStatus) {
    final articleList = await ApiRemote().getArticleList();
    for (var element in articleList) {
      print("article list with internet : ${element}");
      await SyncData().syncRemoteToLocal(element);
    }
  } else {
    final articleList = await ApiLocal().getArticleList();
    for (var element in articleList) {
      print("article list with internet : ${element}");
    }
  }
}

Future searchArticleList(connectivityStatus) async {
  if (connectivityStatus) {
    final articleList = await ApiRemote().searchArticleList("");
    print("Availabe internet ArticleList Search : $articleList");
  } else {
    final articleList = await ApiLocal().searchArticleList("");
    print("No internet ArticleList search : $articleList");
  }
}

Future getCategoryList(connectivityStatus) async {
  if (connectivityStatus) {
    final category = await ApiRemote().getCategoryList();
    print("Availabe internet category : $category");
  } else {
    final category = await ApiLocal().getCategoryList();
    print("No internet category : $category");
  }
}

Future getTypeList(connectivityStatus) async {
  if (connectivityStatus) {
    final type = await ApiRemote().getTypeList();
    print("Availabe internet type : $type");
  } else {
    final type = await ApiLocal().getTypeList();
    print("No internet type : $type");
  }
}

Future<void> updateArticle(connectivityStatus) async {
  if (connectivityStatus) {
    String uuid = "0ea10fa0-d536-11ed-a28e-49dabf5c511f";
    await ApiRemote().updateArticle(uuid);
  } else {
    String uuid = "0ea10fa0-d536-11ed-a28e-49dabf5c511f";
    await ApiLocal().updateArticle(uuid);
  }
}

Future<void> saveArticle(connectivityStatus) async {
  if (connectivityStatus) {
    await ApiRemote().saveArticle();
  } else {
    await ApiLocal().saveArticle();
  }
}

Future deleteArticle(connectivityStatus) async {
  if (connectivityStatus) {
    final article = await ApiRemote().deleteArticle();
    return article;
  } else {
    final article = await ApiLocal().deleteArticle();
    return article;
  }
}

Future syncData() async {
  await SyncData().syncData();
}
