// ignore_for_file: file_names, camel_case_types, must_be_immutable, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenfins_wiki/data/article_db.dart';

class ArticleListController extends GetxController {
  @override
  void onInit() {
   
    super.onInit();
   
  }

  final TextEditingController SearchController = TextEditingController();

  List getArticleList = [].obs;

  getArticle() async {
    getArticleList = await ArticleDB().getArticleData();
    print("=============${getArticleList}");
  }
}
