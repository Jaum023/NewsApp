//We may not use entities on the data layer. That explains why we are using a model here not the entitie itself

import 'package:news_app_flutter/core/resources/data_state.dart';
import 'package:news_app_flutter/features/daily_news/data/models/article.dart';
import 'package:news_app_flutter/features/daily_news/domain/entities/article.dart';
import 'package:news_app_flutter/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() {
    // TODO: implement getNewsArticles
    throw UnimplementedError();
  }

}