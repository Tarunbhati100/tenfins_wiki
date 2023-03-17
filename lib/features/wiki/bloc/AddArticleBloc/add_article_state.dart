import 'package:equatable/equatable.dart';

abstract class AddArticleState extends Equatable {
  const AddArticleState();

  @override
  List get props => [];
  List get categorylist => [];
  List get typelist => [];
}

class AddArticleLoadingState extends AddArticleState {
  @override
  List get props => [];
}

class AddArticleLoadedState extends AddArticleState {
  @override
  final List categorylist;
  @override
  final List typelist;
  const AddArticleLoadedState(this.categorylist, this.typelist);
  @override
  List get props => [];
}

class UpdateArticleState extends AddArticleState {}

class SaveArticleState extends AddArticleState {}

// ignore: must_be_immutable
class AddArticleLoadErrorState extends AddArticleState {
  String errorMessage = "Error";
  AddArticleLoadErrorState(this.errorMessage);
}
