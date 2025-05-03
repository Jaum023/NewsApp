import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app_flutter/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_app_flutter/injection_container.dart';

Future<void> main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DailyNews(),
    ),
    );
  }
}
