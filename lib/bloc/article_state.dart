import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:musiclyric/data/model/api_result_model.dart';

abstract class ArticleState extends Equatable {}

class ArticleInitialState extends ArticleState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends ArticleState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ArticleLoadedState extends ArticleState {
  final List<TrackList> track;
  ArticleLoadedState({@required this.track});
  @override
  List<Object> get props => [track];
}

class ArticleErrorSate extends ArticleState {
  final String message;
  ArticleErrorSate({this.message});
  @override
  List<Object> get props => [message];
}
