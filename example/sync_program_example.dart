import 'package:sync_program/sync_program.dart';

void main() async {
  getCategoryList();
  getTypeList();
}

Future getCategoryList() async {
  final category = await ApiLocal().getCategoryList();
  print("category : $category");
}

Future getTypeList() async {
  final type = await ApiLocal().getCategoryList();
  print("Type : $type");
}
