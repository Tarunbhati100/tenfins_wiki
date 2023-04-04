// ignore_for_file: unused_field, avoid_print, file_names

import 'dart:async';

class ApiLocal {
  Future<List> getCategoryList() async {
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

  Future<List> getTypeList() async {
    List typeCategory = [
      {"id": 0, "title": "InActive"},
      {"id": 1, "title": "Active"},
    ];
    return typeCategory;
  }
}
