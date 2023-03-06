// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_string_escapes

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tenfins_wiki/features/wiki/view/home/homepage.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';
import 'package:tenfins_wiki/services/article_db.dart';

class Article extends GetxController {
  TextEditingController titleController = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();
  final ArticleDataStore articledata = ArticleDataStore();
  ValueNotifier<bool> isUpdate = ValueNotifier<bool>(false);

  String result = '';
  bool isLoading = false;

  List getArticleList = [].obs;
  List<dynamic> searchList = [];

  getArticle() async {
    getArticleList = await ArticleDB().getArticleData();
    update();
  }

  createArticle() async {
    var description = await controller.getText();
    if (description.contains('src=\"data:')) {
      description = '<>';
    }
    ArticleModel resModel =
        ArticleModel(null, titleController.text, description);
    ArticleDB().createArticleDB(resModel).then((res) {});
    Get.to(const HomePage());
    update();
  }

  addArticle() async {
    var description = await controller.getText();
    if (description.contains('src=\"data:')) {
      description = '<>';
    }
    if (isUpdate.value) {
      final article = Articlemodel(
        id: 1,
        title: titleController.text,
        description: description,
      );
      articledata
          .updateArticle(articlemodel: article, index: article.id)
          .then((value) {
        titleController.clear();
        description;
      });
    } else {
      final Article = Articlemodel(
        id: 2,
        title: titleController.text,
        description: description,
      );
      articledata.addArticle(articlemodel: Article).then((value) {
        titleController.clear();
        description;
        update();
        Get.to(const HomePage());
      });
    }
  }
}
