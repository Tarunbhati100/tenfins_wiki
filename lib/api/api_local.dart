// ignore_for_file: annotate_overrides

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sync_program/api/api.dart';
import 'package:uuid/uuid.dart';

class ApiLocal extends Api {
  static final ApiLocal _instance = ApiLocal._();

  ApiLocal._();

  factory ApiLocal() {
    return _instance;
  }

  Future getArticleList() async {
    Box box = Hive.box("tbl_article_local_box");
    List articleList = box.values.toList();
    if (articleList.isEmpty) {
      return [];
    }
    return articleList;
  }

  Future searchArticleList(value) async {
    Box box = Hive.box("tbl_article_local_box");
    List articleList = box.values
        .where((c) => c.title!.toLowerCase().contains(value))
        .toList();
    if (articleList.isEmpty) {
      return [];
    }
    return articleList;
  }
//TODO: add local logic here if you want don't mix the local remote
  Future<List> getCategoryList() async {
    return Future<List>.value([]);
    // return articleCategory;
  }
//TODO: add local logic here if you want don't mix the local remote
  Future<List> getTypeList() async {
    return Future<List>.value([]);
    // return typeCategory;
  }

  Future<void> saveArticle() async {
    String formattedDate = DateFormat('yyyy-MM-dd H:m').format(DateTime.now());
    var uuid = Uuid();
    var uuidarticle = uuid.v1();
    //==================== Start Insert  ==============================//
    Box tblarticlelocalbox = Hive.box("tbl_article_local_box");
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
    await tblarticlelocalbox.add(articlemap);

    //==================== Start Insert change log ==============================//
    var uuidchnagelog = uuid.v4();
    Box tblarticlechangelogbox = Hive.box("tbl_article_changelog_box");
    final changelogbox = {
      "uuid": uuidchnagelog,
      "record_ID": uuidarticle,
      "timestamp": formattedDate,
      "record_type": "insert",
      "sync_status": "0",
    };
    await tblarticlechangelogbox.add(changelogbox);
    //==================== End Insert change log ==============================//
  }

  Future<void> updateArticle(uuidarticle) async {
    String formattedDate = DateFormat('yyyy-MM-dd H:m').format(DateTime.now());
    var uuid = Uuid();
    //==================== Start Update  Article  ==============================//
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

    //==================== Start Insert change log ==============================//
    var uuidchnagelog = uuid.v4();
    Box tblarticlechangelogbox = Hive.box("tbl_article_changelog_box");
    final changelogbox = {
      "uuid": uuidchnagelog,
      "record_ID": uuidarticle,
      "timestamp": formattedDate,
      "record_type": "update",
      "sync_status": "0",
    };
    await tblarticlechangelogbox.add(changelogbox);
    //==================== End Insert change log ==============================//
  }

  Future<void> deleteArticle() async {
    Box tblarticlelocalbox = Hive.box("tbl_article_local_box");
    await tblarticlelocalbox.clear();
    Box tblarticlechangelogbox = Hive.box("tbl_article_changelog_box");
    await tblarticlechangelogbox.clear();
  }
}
