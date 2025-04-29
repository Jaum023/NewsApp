//We may not use entities on the data layer. That explains why we are using a model here not the entitie itself
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_app_flutter/core/constants/constants.dart';
import 'package:news_app_flutter/core/resources/data_state.dart';
import 'package:news_app_flutter/features/daily_news/data/models/article.dart';
import 'package:news_app_flutter/features/daily_news/domain/entities/article.dart';
import 'package:news_app_flutter/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app_flutter/features/daily_news/data/data_sources/remote/news_api_service.dart';


class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {  
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
            type: DioExceptionType.badResponse,
          )
        );
    }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
  }