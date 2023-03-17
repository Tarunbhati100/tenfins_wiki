import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadApiEvent extends HomeEvent {
  @override
  List get props => [];
}

class LoadDeleteArticleEvent extends HomeEvent {
  final int index;
  const LoadDeleteArticleEvent(this.index);

  @override
  List get props => [];
}

class LoadSearchArticleEvent extends HomeEvent {
  final String search;
  const LoadSearchArticleEvent(this.search);

  @override
  List get props => [];
}
