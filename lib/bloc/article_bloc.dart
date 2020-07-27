import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiclyric/bloc/article_event.dart';
import 'package:musiclyric/bloc/article_state.dart';
import 'package:musiclyric/data/model/api_result_model.dart';
import 'package:musiclyric/data/repository/article_repo.dart';
import 'package:meta/meta.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleRepository repository;

  ArticleBloc({ArticleState initialState, @required this.repository})
      : super(initialState);

  @override
  Stream<ArticleState> mapEventToState(ArticleEvent event) async* {
    if (event is FetchArticleEvent) {
      yield ArticleLoadingState();
      try {
        List<TrackList> track = await repository.getArticles();
        yield ArticleLoadedState(track: track);
      } catch (e) {
        yield ArticleErrorSate(message: "No Internet Connection");
      }
    }
  }
}
