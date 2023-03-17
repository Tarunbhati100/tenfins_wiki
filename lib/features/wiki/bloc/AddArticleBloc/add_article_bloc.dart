import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenfins_wiki/repos/article_repository.dart';

import 'add_article_event.dart';
import 'add_article_state.dart';

class AddArticleBloc extends Bloc<AddArticleEvent, AddArticleState> {
  final ArticleRepository _repo;
  AddArticleBloc(this._repo) : super(AddArticleLoadingState()) {
    on<LoadApiEvent>((event, emit) async {
      emit(AddArticleLoadingState());

      List categorylist = await _repo.getCategoryList();
      List typelist = await _repo.getTypeList();
      emit(AddArticleLoadedState(categorylist, typelist));
    });

    on<SaveArticleEvent>((event, emit) async {
      try {
        _repo.saveArticle(event.saveArticle);
      } catch (e) {
        log(e.toString());
      }
      emit(SaveArticleState());
    });

    on<UpdateArticleEvent>((event, emit) async {
      try {
        _repo.updateArticle(event.updateArticle, event.index);
      } catch (e) {
        log(e.toString());
      }
      emit(UpdateArticleState());
    });
  }
}
