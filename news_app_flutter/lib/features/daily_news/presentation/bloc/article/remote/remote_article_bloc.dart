import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/core/resources/data_state.dart';
import 'package:news_app_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app_flutter/features/daily_news/domain/usecases/get_article.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticleEvent, RemoteArticleState> {

  final GetArticleUseCase _getArticlesUseCase;

  RemoteArticlesBloc(this._getArticlesUseCase) : super(const RemoteArticlesLoading()){
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticlesUseCase(null);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    } else if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}