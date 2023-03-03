// ignore_for_file: constant_identifier_names, await_only_futures
import 'package:hive/hive.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:tenfins_wiki/model/databaseModel.dart';
import 'package:isar/isar.dart';
import 'package:tenfins_wiki/model/article.dart';

// DB Helper Class
//====================== Start SQLLITE Database ==================================//
class ArticleDB {
  static Database? _db;
  static const String DB_name = 'articledb.db';
  static const String DB_nameIOS = '/articledb.db';
  static const String TABLE = 'articletbl';
  static const String COL_id = 'id';
  static const String COL_title = 'title';
  static const String COL_message = 'description';

  Future get db async => (_db != null) ? _db : initDB();

  initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    var path = dir.path + (Platform.isAndroid ? DB_name : DB_nameIOS);
    return await openDatabase(path, version: 1, onCreate: onArticleCreateTable);
  }

  // Create Database
  onArticleCreateTable(Database db, int version) async {
    return await db.execute(
        "CREATE TABLE $TABLE ($COL_id INTEGER PRIMARY KEY NOT NULL, $COL_title TEXT, $COL_message TEXT)");
  }

  // Save Database
  createArticleDB(ArticleModel cardModel) async {
    var dbClient = await db;
    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          "INSERT INTO $TABLE($COL_title, $COL_message) VALUES ('${cardModel.title}', '${cardModel.description}')");
    });
  }

  // Get Database
  getArticleData() async {
    var dbClient = await db;
    List data = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List cardModel = [];
    for (int i = 0; i < data.length; i++) {
      cardModel.add(ArticleModel.fromMap(data[i]));
    }
    return cardModel;
  }

  // Check Database
  getArticleDataWhere(String id) async {
    var dbClient = await db;
    List data =
        await dbClient.rawQuery("SELECT * FROM $TABLE WHERE $COL_id=$id");
    return data;
  }

  // Check Database
  checkArticleExist(String title) async {
    var dbClient = await db;
    List data =
        await dbClient.rawQuery("SELECT * FROM $TABLE WHERE $COL_title=$title");
    return data.isEmpty ? false : true;
  }

  // Delete Database
  deleteArticle() async {
    var dbClient = await db;
    return await dbClient.rawDelete("DELETE FROM $TABLE");
  }
}
//====================== End SQLLITE Database ==================================//

//====================== Start Hive Database ==================================//
class ArticleDataStore {
  static const boxName = "ArticleBox";

  // Get reference to an already opened box
  static Box<Articlemodel> box = Hive.box<Articlemodel>(boxName);

  /// Add new article
  Future<void> addArticle({required Articlemodel articlemodel}) async {
    await box.add(articlemodel);
  }

  /// show article list
  Future<void> getArticle({required String id}) async {
    await box.get(id);
  }

  /// update article data
  Future<void> updateArticle(
      {required int index, required Articlemodel articlemodel}) async {
    await box.putAt(index, articlemodel);
  }

  /// delete article
  Future<void> deleteArticle({required int index}) async {
    await box.deleteAt(index);
  }
}
//====================== End Hive Database ==================================//

//====================== Start Isar Database ==================================//
class ArticleProvider {
  late Future<Isar> _db;

  Future get db async => (_db != null) ? _db : initDB();

  initDB() async {
    //  Directory dir = await getApplicationDocumentsDirectory();
    Directory dir = await getApplicationSupportDirectory();
    var path = dir.path + (Platform.isAndroid ? "articledb" : "articledb");

    final isar = await Isar.open([ArticleDataSchema], directory: path);
    isarService();
    return Future.value(Isar.getInstance());
  }

  isarService() {
    _db = OpenDB();
  }

  Future<Isar> OpenDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [ArticleDataSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future SaveArticle(article) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.articleDatas.putSync(article));
  }

  Future getArticle() async {
    final isar = await db;
    return await isar.articleDatas.where().findAll();
  }
}
//====================== End Isar Database ==================================//
