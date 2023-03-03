import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenfins_wiki/data/article_db.dart';

class ArticleListController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  List getArticleList = [].obs;
  List<dynamic> searchList = [];

  getArticle() async {
    getArticleList = await ArticleDB().getArticleData();
    print("=============${getArticleList}");
    update();
  }
}
