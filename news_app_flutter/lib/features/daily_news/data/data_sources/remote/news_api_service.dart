import 'dart:io';

import 'package:retrofit/retrofit.dart';
import 'package:news_app_flutter/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:news_app_flutter/features/daily_news/data/models/article.dart';
part 'news_api_service.g.dart';

@RestApi(baseUrl: newsAPIBaseURL)
abstract class NewsApiService {
  factory NewsApiService(Dio dio, {String baseUrl}) = _NewsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> getNewsArticles({
    @Query("apiKey") String? apiKey,
    @Query("country") String? country,
    @Query("category") String? category,
  });
}