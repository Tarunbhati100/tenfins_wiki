// ignore_for_file: file_names

import 'package:hive/hive.dart';
part 'databaseModel.g.dart';

@HiveType(typeId: 0)
class Articlemodel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? shortdescription;
  @HiveField(3)
  String? category;
  @HiveField(4)
  String? keywords;
  @HiveField(5)
  String? author;
  @HiveField(6)
  String? views;
  @HiveField(7)
  String? likes;
  @HiveField(8)
  String? mentions;
  @HiveField(9)
  String? stars;
  @HiveField(10)
  String? tags;
  @HiveField(11)
  String? type;
  @HiveField(12)
  String? lastUpdated;
  @HiveField(13)
  String? dateTime;
  @HiveField(14)
  String? content;
}
