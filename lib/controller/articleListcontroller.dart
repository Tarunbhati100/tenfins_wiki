
// ignore_for_file: file_names, camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tenfins_wiki/model/article.dart';

class ArticleListController extends GetxController{

final TextEditingController SearchController = TextEditingController();
   final List<Article> article = [
   Article(title: 'John Smith', subtitle: 'By',),
    Article(title: 'Jane Doe', subtitle: 'Good night', ),
    Article(title: 'Bob Johnson', subtitle: 'Hello', ),
    Article(title: 'John Smith', subtitle: 'Hi',),
    Article(title: 'Jane Doe', subtitle: 'Good by', ),
    Article(title: 'Bob Johnson', subtitle: 'Nice', ),
    Article(title: 'John Smith', subtitle: 'Hmmm',),
    Article(title: 'Jane Doe', subtitle: 'By.....', ),
    Article(title: 'Bob Johnson', subtitle: 'Wow....', ),
  ];
}