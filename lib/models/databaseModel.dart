// ignore_for_file: file_names, prefer_typing_uninitialized_variables, unused_import

import 'dart:convert';
import 'package:hive/hive.dart';

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
  final String shortdescription;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String keywords;
  @HiveField(5)
  final String author;
  @HiveField(6)
  final String views;
  @HiveField(7)
  final String likes;
  @HiveField(8)
  final String mentions;
  @HiveField(9)
  final String stars;
  @HiveField(10)
  final String tags;
  @HiveField(11)
  final String type;
  @HiveField(12)
  final String lastUpdated;
  @HiveField(13)
  final String dateTime;
  @HiveField(14)
  final String content;

  Articlemodel({
    required this.id,
    required this.title,
    required this.shortdescription,
    required this.category,
    required this.keywords,
    required this.author,
    required this.views,
    required this.likes,
    required this.mentions,
    required this.stars,
    required this.tags,
    required this.type,
    required this.lastUpdated,
    required this.dateTime,
    required this.content,
  });
}
