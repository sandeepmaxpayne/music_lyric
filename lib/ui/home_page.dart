import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiclyric/bloc/article_bloc.dart';
import 'package:musiclyric/bloc/article_event.dart';
import 'package:musiclyric/bloc/article_state.dart';
import 'package:musiclyric/data/model/api_result_model.dart';
import 'package:musiclyric/ui/article_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
    articleBloc = BlocProvider.of<ArticleBloc>(context);
    articleBloc.add(FetchArticleEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text(
                  'Trending',
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      articleBloc.add(FetchArticleEvent());
                    },
                  ),
                ],
              ),
              body: Container(
                child: BlocListener<ArticleBloc, ArticleState>(
                  listener: (context, state) {
                    if (state is ArticleErrorSate) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                    }
                  },
                  child: BlocBuilder<ArticleBloc, ArticleState>(
                    builder: (context, state) {
                      if (state is ArticleInitialState) {
                        return buildLoading();
                      } else if (state is ArticleLoadingState) {
                        return buildLoading();
                      } else if (state is ArticleLoadedState) {
                        return buildArticleList(state.track);
                      } else if (state is ArticleErrorSate) {
                        return buildErrorUI(state.message);
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUI(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<TrackList> track) {
    return ListView.builder(
      itemCount: track.length,
      itemBuilder: (ct, pos) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: Icon(Icons.library_music),
              title: Text(
                track[pos].track.trackName,
                maxLines: 1,
              ),
              subtitle: Text(
                track[pos].track.albumName,
                maxLines: 1,
              ),
              trailing: Text(
                track[pos].track.artistName,
                maxLines: 1,
              ),
            ),
            onTap: () {
              print("track id: ${track[pos].track.trackId}");
              navigateToArticleDetailPage(context, track[pos].track);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Track track) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        track: track,
      );
    }));
  }
}
