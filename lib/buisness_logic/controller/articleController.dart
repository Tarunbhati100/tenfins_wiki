// ignore_for_file: file_names, unnecessary_string_escapes, avoid_print, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tenfins_wiki/data/article_db.dart';
import 'package:tenfins_wiki/model/article.dart';

class ArticleController extends GetxController {
  TextEditingController titleController = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();
  final ArticleDataStore Articledata = ArticleDataStore();
  ValueNotifier<bool> isUpdate = ValueNotifier<bool>(false);
  ArticleProvider articleProvider = ArticleProvider();

  var articlelistdata;

  String result = '';
  bool isLoading = false;

  saveArticle() async {
    var description = await controller.getText();
    if (description.contains('src=\"data:')) {
      description = '<>';
    }
    articleProvider.SaveArticle(
      articleData()..id,
    );
    articleProvider.SaveArticle(
      articleData()..title = titleController.text,
    );
    articleProvider.SaveArticle(
      articleData()..description = description,
    );
    print("==================");
  }

  getArticle() async {
    articlelistdata = articleProvider.getArticle();
    print("articlelistdata ::::: ${articlelistdata.toString()}");
  }
}
