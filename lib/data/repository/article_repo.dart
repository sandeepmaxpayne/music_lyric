import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:musiclyric/data/model/api_result_model.dart';
import 'package:musiclyric/res/string.dart';

abstract class ArticleRepository {
  Future<List<TrackList>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<TrackList>> getArticles() async {
    var response = await http.get(AppString.musicChart);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<TrackList> track =
          ApiResultModel.fromJson(data).message.body.trackList;

      print("tracklist: ${track[0].track.trackName}");
      return track;
    } else {
      throw "No Internet Connection";
    }
  }
}
