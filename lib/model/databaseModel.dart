// ignore_for_file: file_names

import 'dart:convert';

class ArticleModel {
  int? id;
  String? title;
  var description;

  ArticleModel(this.id, this.title, this.description);

  ArticleModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    description = map['description'];
  }
}
