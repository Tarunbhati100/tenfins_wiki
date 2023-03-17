import 'package:tenfins_wiki/models/databaseModel.dart';
import 'package:tenfins_wiki/services/api.dart';

class ArticleRepository {
  final JsonApi api = JsonApi();

  Future getArticleList() async {
    final article = await api.getArticleList();
    return article;
  }

  Future searchArticleList(value) async {
    final article = await api.searchArticleList(value);
    return article;
  }

  Future getCategoryList() async {
    final category = await api.getArticleCategoryList();
    return category;
  }

  Future getTypeList() async {
    final type = await api.getArticleTypeList();
    return type;
  }

  Future<void> updateArticle(Articlemodel article, index) async {
    await api.updateArticle(article, index);
  }

  Future<void> saveArticle(Articlemodel article) async {
    await api.saveArticle(article);
  }

  Future deleteArticle(index) async {
    final article = await api.deleteArticle(index);
    return article;
  }
}
