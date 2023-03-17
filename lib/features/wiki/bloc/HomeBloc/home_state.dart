import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List get props => [];

  get articlelist => [];
}

class HomeLoadingState extends HomeState {
  @override
  List get props => [];
}

class HomeLoadedState extends HomeState {
  @override
  final List articlelist;
  const HomeLoadedState(this.articlelist);

  @override
  List get props => [];
}

// ignore: must_be_immutable
class HomeErrorState extends HomeState {
  String errorMessage = "Article No Found";
  HomeErrorState(this.errorMessage);
}
