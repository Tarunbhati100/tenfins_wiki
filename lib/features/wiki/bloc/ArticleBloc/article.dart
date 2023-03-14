// ignore_for_file: non_constant_identifier_names, unused_local_variable, unnecessary_string_escapes, avoid_print, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
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

   bool isOpened = false;

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> endSideMenuKey = GlobalKey<SideMenuState>();

  @override
  void onInit() {
    getArticleCategoryList();
    getArticleTypeList();
    super.onInit();
  }

   toggleMenu([bool end = false]) {
    if (end) {
      final _state = endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  getArticleCategoryList() async {
    articleCategoryList.value = await JsonApi().getArticleCategoryList();
    print("articleCategoryList : $articleCategoryList");
  }

  getArticleTypeList() async {
    articleTypeList.value = await JsonApi().getArticleTypeList();
    update();
  }

  //=================================================

  deleteArticle(int index) {
    articledata.deleteArticle(index: index);
    update();
  }

  editArticle(int index, Articlemodel articlemodel) {
    articledata.updateArticle(index: index, articlemodel: articlemodel);
    Get.to(const HomePage());
    update();
  }

  Future<void> addArticle() async {
    
    var description = await controller.getText();
    if (description.contains('src=\"data:') && description.contains('src=\"img:')) {
      description = '<>';
    }
    print("Update");  
    print(selectedCategory);

    final article = Articlemodel()
      ..id = 1
      ..title = titleController.text
      ..shortdescription = shortDescription.text
      ..category = selectedCategory.toString()
      ..keywords = keywords.text
      ..author = author.text
      ..views = ""
      ..likes = ""
      ..mentions = mentions.text
      ..stars = stars.text
      ..tags = tags.text
      ..type = selectedType.toString()
      ..lastUpdated = ""
      ..dateTime = ""
      ..content = description;

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
    });
  }
  Future<void> updateArticle(index) async {
    var description = await controller.getText();
    if (description.contains('src=\"data:') && description.contains('src=\"img:')) {
      description = '<>';
    }
    print("Update");
    print(selectedCategory);

    final article = Articlemodel()
      ..id = 1
      ..title = titleController.text
      ..shortdescription = shortDescription.text
      ..category = selectedCategory.toString()
      ..keywords = keywords.text
      ..author = author.text
      ..views = ""
      ..likes = ""
      ..mentions = mentions.text
      ..stars = stars.text
      ..tags = tags.text
      ..type = selectedType.toString()
      ..lastUpdated = ""
      ..dateTime = ""
      ..content = description;

    articledata.updateArticle(index: index, articlemodel: article).then((value) {
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
    });
  }

  setArticleData(articleData) {
    titleController.text = articleData!.title!;
    shortDescription.text = articleData!.shortdescription!;
    selectedCategory = articleData!.category!;
    keywords.text = articleData!.keywords!;
    author.text = articleData!.author!;
    selectedType = articleData!.type!;
    stars.text = articleData!.stars!;
    tags.text = articleData!.tags!;
    // controller.insertHtml("<p>Hello</p>");
  }

  cleanArticleData() {
    titleController.clear();
    shortDescription.clear();
    keywords.clear();
    author.clear();
    mentions.clear();
    stars.clear();
    tags.clear();
    selectedType;
    selectedCategory;
  }
}
