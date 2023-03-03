import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenfins_wiki/buisness_logic/blocs/addArticlebloc/home_article_event.dart';
import 'package:tenfins_wiki/buisness_logic/blocs/addArticlebloc/home_article_state.dart';
import 'package:tenfins_wiki/data/repositories/homeArticle_repositories.dart';

class HomeArticleBloc extends Bloc<HomeArticleEvent, HomeArticleState>{
  final HomeArticlerepositories _homeArticlerepositories;
HomeArticleBloc(this._homeArticlerepositories):super(HomeArticleLoadingState()){

  on<HomeArticleLoadedEvent>((event, emit) {
    emit(HomeArticleLoadingState());
    final homeArticle = _homeArticlerepositories.getArticle();
    emit(HomeArticleLodadState(homeArticle));
  },);
}
}