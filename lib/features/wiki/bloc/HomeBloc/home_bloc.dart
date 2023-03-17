import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenfins_wiki/repos/article_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ArticleRepository _repo;
  HomeBloc(this._repo) : super(HomeLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());

      List articlelist = await _repo.getArticleList();
      emit(HomeLoadedState(articlelist));
    });

    on<LoadDeleteArticleEvent>((event, emit) async {
      emit(HomeLoadingState());
      await _repo.deleteArticle(event.index);
      List articlelist = await _repo.getArticleList();
      emit(HomeLoadedState(articlelist));
    });

    on<LoadSearchArticleEvent>((event, emit) async {
      emit(HomeLoadingState());
      List articlelist;
      if (event.search.isNotEmpty) {
        articlelist = await _repo.searchArticleList(event.search);
      } else {
        articlelist = await _repo.getArticleList();
      }
      emit(HomeLoadedState(articlelist));
    });
  }
}
