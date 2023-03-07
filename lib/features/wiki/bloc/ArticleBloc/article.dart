// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_string_escapes, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tenfins_wiki/features/wiki/view/home/homepage.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';
import 'package:tenfins_wiki/services/api.dart';
import 'package:tenfins_wiki/services/article_db.dart';

class Article extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController shortDescription = TextEditingController();
  TextEditingController keywords = TextEditingController();
  TextEditingController searchArticle = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController tags = TextEditingController();
  TextEditingController mentions = TextEditingController();
  TextEditingController stars = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();
  final ArticleDataStore articledata = ArticleDataStore();
  ValueNotifier<bool> isUpdate = ValueNotifier<bool>(false);

  String result = '';
  bool isLoading = false;

  List getArticleList = [].obs;

  List<dynamic> searchList = [];

  RxList articleCategoryList = [].obs;
  //Map selectedCategory = {"id": 0, "categoryname": "Motivation"}.obs;
  var selectedCategory;

  RxList articleTypeList = [].obs;
  //Map selectedCategory = {"id": 0, "categoryname": "Motivation"}.obs;
  var selectedType;

  @override
  void onInit() {
    getArticleCategoryList();
    getArticleTypeList();
    getArticleTypeList();
    super.onInit();
  }

  getArticleCategoryList() async {
    articleCategoryList.value = await JsonApi().getArticleCategoryList();
    print("articleCategoryList : $articleCategoryList");
    update();
  }

  getArticleTypeList() async {
    articleTypeList.value = await JsonApi().getArticleTypeList();
    update();
  }

  getArticle() async {
    getArticleList = await ArticleDB().getArticleData();
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
        shortdescription: shortDescription.text,
        category: selectedCategory,
        keywords: keywords.text,
        author: author.text,
        views: "",
        likes: "",
        mentions: mentions.text,
        stars: stars.text,
        tags: tags.text,
        type: selectedType,
        lastUpdated: "",
        dateTime: "",
        content: description,
      );
      articledata
          .updateArticle(articlemodel: article, index: article.id)
          .then((value) {
        titleController.clear();
        shortDescription.clear();
        keywords.clear();
        author.clear();
        mentions.clear();
        stars.clear();
        tags.clear();
        selectedType;
        selectedCategory;
        description;
      });
    } else {
      final article = Articlemodel(
        id: 1,
        title: titleController.text,
        shortdescription: shortDescription.text,
        category: selectedCategory,
        keywords: keywords.text,
        author: author.text,
        views: "",
        likes: "",
        mentions: mentions.text,
        stars: stars.text,
        tags: tags.text,
        type: selectedType,
        lastUpdated: "",
        dateTime: "",
        content: description,
      );
      articledata.addArticle(articlemodel: article).then((value) {
        titleController.clear();
        shortDescription.clear();
        keywords.clear();
        author.clear();
        mentions.clear();
        stars.clear();
        tags.clear();
        selectedType;
        selectedCategory;
        description;
        update();
        Get.to(const HomePage());
      });
    }
  }
}
