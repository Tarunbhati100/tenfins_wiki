import 'package:sync_program/common/component.dart';
import 'package:sync_program/models/databaseModel.dart';
import 'package:sync_program/sync_program.dart';

void main() async {
  hiveInit();
  bool connectivityStatus = false;
  saveArticle(article);
  // getArticleList(connectivityStatus);
//  searchArticleList(connectivityStatus);
  // getCategoryList(connectivityStatus);
//  getTypeList(connectivityStatus);
}

Future getArticleList(connectivityStatus) async {
  if (connectivityStatus) {
    final articleList = await ApiRemote().getArticleList();
    print("Availabe internet ArticleList : $articleList");
  } else {
    final articleList = await ApiLocal().getArticleList();
    print("No internet ArticleList : $articleList");
  }
}

Future searchArticleList(connectivityStatus) async {
  if (connectivityStatus) {
    final articleList = await ApiRemote().searchArticleList("");
    print("Availabe internet ArticleList Search : $articleList");
  } else {
    final articleList = await ApiLocal().searchArticleList("");
    print("No internet ArticleList search : $articleList");
  }
}

Future getCategoryList(connectivityStatus) async {
  if (connectivityStatus) {
    final category = await ApiRemote().getCategoryList();
    print("Availabe internet category : $category");
  } else {
    final category = await ApiLocal().getCategoryList();
    print("No internet category : $category");
  }
}

Future getTypeList(connectivityStatus) async {
  if (connectivityStatus) {
    final type = await ApiRemote().getTypeList();
    print("Availabe internet type : $type");
  } else {
    final type = await ApiLocal().getTypeList();
    print("No internet type : $type");
  }
}

Future<void> updateArticle(Articlemodel article, index) async {
  await ApiLocal().updateArticle(article, index);
}

Future<void> saveArticle(Articlemodel article) async {
  await ApiLocal().saveArticle(article);
}

Future deleteArticle(index) async {
  final article = await ApiLocal().deleteArticle(index);
  return article;
}
