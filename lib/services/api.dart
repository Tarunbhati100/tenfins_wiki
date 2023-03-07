abstract class ApiBase {
  Future<List> getArticleCategoryList();
}

class JsonApi extends ApiBase {
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
}
