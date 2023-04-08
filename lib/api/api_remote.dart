// ignore_for_file: annotate_overrides

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sync_program/api/api.dart';
import 'package:sync_program/Remote/remote_data.dart';
import 'package:uuid/uuid.dart';

class ApiRemote extends Api {
  static final ApiRemote _instance = ApiRemote._();

  ApiRemote._();

  factory ApiRemote() {
    return _instance;
  }

  Future getArticleList() async {
    Box box = Hive.box("tbl_article_remote");
    List articleList = box.values.toList();
    if (articleList.isEmpty) {
      return [];
    }
    return articleList;
  }

  Future searchArticleList(value) async {
    Box box = Hive.box("tbl_article_remote");
    List articleList = box.values
        .where((c) => c.title!.toLowerCase().contains(value))
        .toList();
    if (articleList.isEmpty) {
      return [];
    }
    return articleList;
  }

  Future<List> getCategoryList() async {
    return RemoteData().articleCategory;
  }

  Future<List> getTypeList() async {
    return RemoteData().typeCategory;
  }

  Future<void> saveArticle() async {
    String formattedDate = DateFormat('yyyy-MM-dd H:m').format(DateTime.now());
    var uuid = Uuid();
    var uuidarticle = uuid.v1();
    //==================== Start Insert change log ==============================//
    Box tblarticleremote = Hive.box("tbl_article_remote");
    final articlemap = {
      "uuid": uuidarticle,
      "title": "Demo Article",
      "shortdescription": "This is a motivation article",
      "category": "Motivation",
      "keywords": "new",
      "author": "Bert",
      "views": "",
      "likes": "",
      "mentions": "nit",
      "stars": "3",
      "tags": "4",
      "type": "Active",
      "lastUpdated": formattedDate,
      "dateTime": formattedDate,
      "content": "<p>This is a motivation article</p>"
    };
    await tblarticleremote.add(articlemap);
  }

  Future<void> updateArticle(uuidarticle) async {
    String formattedDate = DateFormat('yyyy-MM-dd H:m').format(DateTime.now());
    Box tblarticlelocalbox = Hive.box("tbl_article_local_box");
    final articlemap = {
      "uuid": uuidarticle,
      "title": "Demo Update Article 111",
      "shortdescription": "This is a motivation article",
      "category": "Motivation",
      "keywords": "new",
      "author": "Bert",
      "views": "",
      "likes": "",
      "mentions": "nit",
      "stars": "3",
      "tags": "4",
      "type": "Active",
      "lastUpdated": formattedDate,
      "content": "<p>This is a Update motivation article</p>"
    };
    await tblarticlelocalbox.putAt(0, articlemap);
  }

  Future<void> deleteArticle() async {
    Box tblarticleremote = Hive.box("tbl_article_remote");
    await tblarticleremote.clear();
  }
}
