// ignore_for_file: camel_case_types

import 'package:isar/isar.dart';

part 'article.g.dart';

@Collection()
class articleData {
  Id id = Isar.autoIncrement;
  String? title;
  String? description;
}
