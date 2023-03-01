// ignore_for_file: file_names, camel_case_types, must_be_immutable, non_constant_identifier_names, unnecessary_brace_in_string_interps, avoid_print
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenfins_wiki/data/article_db.dart';

class ArticleListController extends GetxController {

  final TextEditingController SearchController = TextEditingController();

  List getArticleList = [].obs;
  List<dynamic> searchList = [];
   
  //   getArticle() async {
  //   getArticleList = await ArticleDB().getArticleData();
  //   print("=============${getArticleList}");
  //   update();
  // }

   getArticle() async {
    getArticleList = await ArticleDB().getArticleData();
    print("=============${getArticleList}");
    update();
  }
  
}
