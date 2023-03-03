import 'package:equatable/equatable.dart';
import 'package:tenfins_wiki/model/databaseModel.dart';

abstract class HomeArticleState extends Equatable {}
class HomeArticleLoadingState extends HomeArticleState{
  @override
  List<Object?> get props => [];

}

class HomeArticleLodadState extends HomeArticleState{
   final List<ArticleModel> articleModel;
 HomeArticleLodadState(this.articleModel);
  @override
  List<Object?> get props => [articleModel];

}