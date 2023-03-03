import 'package:flutter/material.dart';
import 'package:tenfins_wiki/data/article_db.dart';

class HomeArticlerepositories {
  final TextEditingController searchController = TextEditingController();

  List getArticleList = [];
  List<dynamic> searchList = [];
  getArticle() async {
    getArticleList = await ArticleDB().getArticleData();
    // ignore: avoid_print
    print("=============${getArticleList}");
  }
}
