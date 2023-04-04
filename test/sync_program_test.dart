import 'package:sync_program/sync_program.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    Future getCategoryList() async {
      final category = await ApiLocal().getCategoryList();
      return category;
    }

    Future getTypeList() async {
      final category = await ApiLocal().getCategoryList();
      return category;
    }
  });
}
