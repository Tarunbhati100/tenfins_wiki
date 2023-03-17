import 'package:hive/hive.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';

abstract class ApiBase {
  Future<List> getArticleCategoryList();
}

class JsonApi extends ApiBase {
  Future getArticleList() async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    List articleList = box.values.toList();
    if (articleList.isEmpty) {
      return [];
    }
    return articleList;
  }

  Future searchArticleList(value) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    List articleList = box.values
        .where((c) => c.title!.toLowerCase().contains(value))
        .toList();
    if (articleList.isEmpty) {
      return [];
    }
    return articleList;
  }

  @override
  Future<List> getArticleCategoryList() async {
    List articleCategory = [
      {"id": 0, "categoryname": "Motivation"},
      {"id": 1, "categoryname": "Life Lessons"},
      {"id": 3, "categoryname": "Creativity"},
      {"id": 4, "categoryname": "Habits"},
      {"id": 5, "categoryname": "Focus"},
      {"id": 6, "categoryname": "Productivity"},
    ];
    return articleCategory;
  }

  Future<List> getArticleTypeList() async {
    List typeCategory = [
      {"id": 0, "title": "InActive"},
      {"id": 1, "title": "Active"},
    ];
    return typeCategory;
  }

  Future<void> saveArticle(Articlemodel article) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.add(article);
    article.save();
  }

  Future<void> updateArticle(Articlemodel updateArticle, index) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.putAt(index, updateArticle);
  }

  Future<void> deleteArticle(index) async {
    Box<Articlemodel> box = Hive.box<Articlemodel>("WikiBox");
    await box.deleteAt(index);
  }
}
