// ignore_for_file: unused_field, avoid_print, file_names
import 'dart:async';
import 'package:hive/hive.dart';

//TODO: use the classes functions to create a clean sync logic
class SyncData {
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
