// ignore_for_file: file_names

// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tenfins_wiki/data/article_db.dart';
import 'package:tenfins_wiki/model/databaseModel.dart';
import 'package:tenfins_wiki/presentation/views/home/homepage.dart';

class AddArticleController extends GetxController {
  @override
  void onInit() {
    
    super.onInit();
  }

  TextEditingController titleController = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();

  String result = '';
  bool isLoading = false;
  
  
  createArticle()async{
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

     
  }
}
