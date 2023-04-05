/// Support for doing something awesome.
///
/// More dartdocs go here.
library sync_program;

import 'dart:io';

import 'package:hive/hive.dart';

import 'models/databaseModel.dart';

export 'src/sync_program_base.dart';

void main() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter<Articlemodel>(ArticlemodelAdapter());
  await Hive.openBox<Articlemodel>("WikiBox");
}

// TODO: Export any libraries intended for clients of this package.
