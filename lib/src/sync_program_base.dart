// ignore_for_file: unused_field, avoid_print, file_names
import 'dart:async';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:sync_program/common/component.dart';
import 'package:uuid/uuid.dart';

abstract class ApiBase {}

class ApiLocal extends ApiBase {
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

  Future<List> getCategoryList() async {
    return articleCategory;
  }

  Future<List> getTypeList() async {
    return typeCategory;
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

class ApiRemote extends ApiBase {
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
    return articleCategory;
  }

  Future<List> getTypeList() async {
    return typeCategory;
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

class SyncData extends ApiBase {
  //------------- Sync Local To Remote Data --------------------------//
  Future<void> syncData() async {
    Box tblarticlechangelogbox = Hive.box("tbl_article_changelog_box");
    List changelogList = tblarticlechangelogbox.values
        .where((c) => c['sync_status']!.toLowerCase().contains("0"))
        .toList();
    if (changelogList.isEmpty) {
      print("changelogList : $changelogList");
      int index = 0;
      for (var changelog in changelogList) {
        //================ Start Local to Remote Sync =================================//
        Box tblarticlelocalbox = Hive.box("tbl_article_local_box");
        List articleList = tblarticlelocalbox.values
            .where((c) => c['uuid'].toLowerCase().contains(changelog['uuid']))
            .toList();
        if (articleList.isEmpty) {
          int j = 0;
          for (var article in articleList) {
            Box tblarticleremote = Hive.box("tbl_article_remote");
            final articlemap = {
              "uuid": article['uuid'],
              "title": article['title'],
              "shortdescription": article['shortdescription'],
              "category": article['category'],
              "keywords": article['keywords'],
              "author": article['author'],
              "views": article['views'],
              "likes": article['likes'],
              "mentions": article['mentions'],
              "stars": article['stars'],
              "tags": article['tags'],
              "type": article['type'],
              "lastUpdated": article['lastUpdated'],
              "dateTime": article['dateTime'],
              "content": article['content']
            };
            if (changelog['record_type'] == "update") {
              await tblarticlelocalbox.putAt(j, articlemap);
            } else {
              await tblarticleremote.add(articlemap);
            }
            j++;
          }
        }
        //================ End Local to Remote Sync =================================//
        //================== Update Change Log =============================//
        final changelogbox = {
          "uuid": changelog['uuid'],
          "record_ID": changelog['record_ID'],
          "timestamp": changelog['timestamp'],
          "record_type": "insert",
          "sync_status": "1",
        };
        await tblarticlechangelogbox.putAt(index, changelogbox);
        //================== End Update Change Log =============================//
        index++;
      }
    }
  }
  //----------------------- End --------------------------//

  //------------- Sync Remote To Local Data --------------------------//
  Future<void> syncRemoteToLocal(article) async {
    Box tblarticlelocalbox = Hive.box("tbl_article_local_box");
    final articlemap = {
      "uuid": article['uuid'],
      "title": article['title'],
      "shortdescription": article['shortdescription'],
      "category": article['category'],
      "keywords": article['keywords'],
      "author": article['author'],
      "views": article['views'],
      "likes": article['likes'],
      "mentions": article['mentions'],
      "stars": article['stars'],
      "tags": article['tags'],
      "type": article['type'],
      "lastUpdated": article['lastUpdated'],
      "dateTime": article['dateTime'],
      "content": article['content']
    };
    List articleList = tblarticlelocalbox.values
        .where((c) => c['uuid'].toLowerCase().contains(article['uuid']))
        .toList();
    if (articleList.isEmpty) {
      await tblarticlelocalbox.add(articlemap);
    } else {
      await tblarticlelocalbox.putAt(0, articlemap);
    }
  }
}
