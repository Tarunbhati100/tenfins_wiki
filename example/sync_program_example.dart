import 'app.dart';

void main() async {
  final App app = App();
  await app.hiveInit();
  bool connectivityStatus = false;

  // saveArticle(connectivityStatus);
  app.updateArticle(connectivityStatus);
  app.getArticleList(connectivityStatus);

  app.syncData();
  // deleteArticle(connectivityStatus);
  // searchArticleList(connectivityStatus);
  // getCategoryList(connectivityStatus);
  // getTypeList(connectivityStatus);
}
