// ignore_for_file: unused_field, avoid_print, file_names

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';

abstract class ApiBase {
  // ----------- user data ---------------//
  Map login(String userName, String password);
  Future getProfile(userEmail);
  updateProfile(user, index);
  Future findUser();

  Future getFriends();
  addFriend();

  // ----------- Article data ---------------//
  Future getKnowledgeArticle();
  Future findKnowledgeArticle(value);
  addKnowledgeArticle(Articlemodel article);
  updateKnowledgeArticle(Articlemodel article, index);
  deleteKnowledgeArticle(index);

  // ----------- Post data ---------------//
  Future getPosts();
  addPosts();

  // ----------- Fix List data ---------------//
  Future getCategoryList();
  Future getTypeList();

  //-------------- Logout --------------------//
  Future logout();
}

class ApiLocal extends ApiBase {
  // -------------------- Satrt User ---------------------------------------------//
  @override
  Map login(String userName, String password) {
    return {"uid": 1001, "fullName": "Bert Beckmann", "loggedIn": true};
  }

  @override
  Future getProfile(userEmail) async {
    final box = Hive.box('user');
    var user = box.get(userEmail);
    if (user == null) {
      throw "User Profile not found in local Storage";
    }
    return user;
  }

  @override
  updateProfile(user, index) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("user");
    await box.putAt(index, user);
  }

  @override
  Future getFriends() async {
    return [];
  }

  @override
  Future findUser() async {
    return [];
  }

  @override
  Future<void> addFriend() async {}
  // -------------------- end User ---------------------------------------------//

  // -------------------- Satrt Article ---------------------------------------------//
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  @override
  Future getKnowledgeArticle() async {
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
      //------------- Sync Remote To Local Data --------------------------//
      //  syncRemoteToLocalData(articleList);
      if (articleList.isEmpty) {
        return [];
      }
      return articleList;
    }
  }

  @override
  Future findKnowledgeArticle(value) async {
    var result = await _connectivity.checkConnectivity();
    print("resultresult : $result");
    if (result == ConnectivityResult.none) {
      Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
      List articleList = box.values
          .where((c) => c.title!.toLowerCase().contains(value))
          .toList();
      if (articleList.isEmpty) {
        return [];
      }
      return articleList;
    } else {
      Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
      List articleList = box.values
          .where((c) => c.title!.toLowerCase().contains(value))
          .toList();
      if (articleList.isEmpty) {
        return [];
      }
      return articleList;
    }
  }

  @override
  Future<void> addKnowledgeArticle(Articlemodel article) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.add(article);
    article.save();
  }

  @override
  Future<void> updateKnowledgeArticle(Articlemodel article, index) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.putAt(index, article);
  }

  @override
  Future<void> deleteKnowledgeArticle(index) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.deleteAt(index);
  }

  // -------------------- end Article ---------------------------------------------//

  //------------------------- Fix List ---------------------------------//
  @override
  Future<List> getCategoryList() async {
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

  @override
  Future<List> getTypeList() async {
    List typeCategory = [
      {"id": 0, "title": "InActive"},
      {"id": 1, "title": "Active"},
    ];
    return typeCategory;
  }
  //------------------------- End List -----------------------------------------//

  //------------------------- Post -----------------------------------------//
  @override
  Future<void> addPosts() async {}

  @override
  Future<List> getPosts() async {
    return [];
  }
  // -------------------- end Post ---------------------------------------------//

  //------------------- Logout ---------------------------//
  @override
  Future logout() async {
    return true;
  }
  //------------------- end Logout ---------------------------//

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
  // ----------------------- End ------------------------- //
}

class ApiRemote extends ApiBase {
  // -------------------- Satrt User ---------------------------------------------//
  @override
  Map login(String userName, String password) {
    return {"uid": 1001, "fullName": "Bert Beckmann", "loggedIn": true};
  }

  @override
  Future getProfile(userEmail) async {
    return [];
  }

  @override
  updateProfile(user, index) async {}

  @override
  Future getFriends() async {
    return [];
  }

  @override
  Future findUser() async {
    return [];
  }

  @override
  Future<void> addFriend() async {}
  // -------------------- end User ---------------------------------------------//

  // -------------------- Satrt Article ---------------------------------------------//
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivitySubscription;

  @override
  Future getKnowledgeArticle() async {
    return [];
  }

  @override
  Future findKnowledgeArticle(value) async {
    return [];
  }

  @override
  Future<void> addKnowledgeArticle(Articlemodel article) async {}

  @override
  Future<void> updateKnowledgeArticle(Articlemodel article, index) async {}

  @override
  Future<void> deleteKnowledgeArticle(index) async {}
  // -------------------- end Article ---------------------------------------------//

  //------------------------- Fix List ---------------------------------//
  @override
  Future<List> getCategoryList() async {
    return [];
  }

  @override
  Future<List> getTypeList() async {
    return [];
  }
  // -------------------- end List ---------------------------------------------//

  //------------------------- Post -----------------------------------------//
  @override
  Future<void> addPosts() async {}

  @override
  Future<List> getPosts() async {
    return [];
  }
  // -------------------- end Post ---------------------------------------------//

  //------------------- Logout ---------------------------//
  @override
  Future logout() async {
    return true;
  }
  // -------------------- end Logout ---------------------------------------------//

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
  // ----------------------- End ------------------------- //
}
