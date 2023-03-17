// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:equatable/equatable.dart';
import 'package:tenfins_wiki/models/databaseModel.dart';

abstract class AddArticleEvent extends Equatable {
  const AddArticleEvent();
}

class LoadApiEvent extends AddArticleEvent {
  @override
  List get props => [];
}

class SaveArticleEvent extends AddArticleEvent {
  final Articlemodel saveArticle;
  const SaveArticleEvent(this.saveArticle);
  @override
  List get props => [];
}

class UpdateArticleEvent extends AddArticleEvent {
  final Articlemodel updateArticle;
  final int index;
  const UpdateArticleEvent(this.updateArticle, this.index);

  @override
  List get props => [];
}
