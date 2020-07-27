import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:musiclyric/data/model/api_result_model.dart';
import 'package:musiclyric/data/model/lyric_model.dart';
import 'package:http/http.dart' as http;
import 'package:musiclyric/res/string.dart';

class ArticleDetailPage extends StatefulWidget {
  final Track track;

  ArticleDetailPage({this.track});

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  String bodyLyrics;
  Future<String> getLyrics(int trackID) async {
    var response = await http.get(AppString.musicLyric(trackID.toString()));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      Lyrics lyrics = Lyric.fromJson(data).message.body.lyrics;
      return lyrics.lyricsBody;
    } else {
      throw Exception();
    }
  }

  void getbody() async {
    var body = await getLyrics(widget.track.trackId);
    setState(() {
      bodyLyrics = body;
    });
  }

  @override
  void initState() {
    super.initState();

    getbody();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Track Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(5.0),
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Name",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(widget.track.trackName)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Artist",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(widget.track.artistName)
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Explicit",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(widget.track.explicit == 0 ? "False" : "True")
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Rating",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(widget.track.trackRating.toString())
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Lyrics",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(bodyLyrics == null ? "" : bodyLyrics)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
