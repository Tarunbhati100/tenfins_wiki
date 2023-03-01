

// ignore_for_file: file_names, unnecessary_string_escapes, avoid_print, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tenfins_wiki/data/article_db.dart';
import 'package:tenfins_wiki/model/databaseModel.dart';
import 'package:tenfins_wiki/presentation/views/home/homepage.dart';

class AddArticleController extends GetxController {

  TextEditingController titleController = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();
  final ArticleDataStore Articledata = ArticleDataStore();
  ValueNotifier<bool> isUpdate = ValueNotifier<bool>(false);

  String result = '';
  bool isLoading = false;

  createArticle() async {
     var description = await controller.getText();
    if (description.contains('src=\"data:')) {
     description = '<>';
    }
    print("description $description");
     ArticleModel resModel =
     ArticleModel(null, titleController.text, description);
     ArticleDB().createArticleDB(resModel).then((res) {
     });
    Get.to(const HomePage());
    update();
  }

  AddArticle() async {
    var description = await controller.getText();
    if (description.contains('src=\"data:')) {
      description = '<>';
    }
    if (isUpdate.value) {
      final Article = Articlemodel(
        id: 1,
        title: titleController.text,
        description: description,
      );
      Articledata.updateArticle(
              articlemodel: Article, index: Article.id)
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
    Articledata.addArticle(articlemodel: Article)
          .then((value) {
        titleController.clear();
        description;
        print("Articledata------------$Article");
        print(Article.title);
        update();
        Get.to(const HomePage());
      });
    }
  }
}
