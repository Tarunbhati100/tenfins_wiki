// ignore_for_file: file_names, prefer_typing_uninitialized_variables, unused_import

import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

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


@HiveType(typeId: 0)
class Articlemodel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;

  Articlemodel({
    required this.id,
    required this.title,
    required this.description,
  }); 
}

