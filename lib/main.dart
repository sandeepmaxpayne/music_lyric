import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiclyric/bloc/article_bloc.dart';
import 'package:musiclyric/bloc/article_state.dart';
import 'package:musiclyric/data/repository/article_repo.dart';
import 'package:musiclyric/ui/home_page.dart';

void main() {
  runApp(MyLyricApp());
}

class MyLyricApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => ArticleBloc(
            repository: ArticleRepositoryImpl(),
            initialState: ArticleInitialState()),
        child: HomePage(),
      ),
    );
  }
}
