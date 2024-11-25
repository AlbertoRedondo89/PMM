import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:movies_app/models/now_playing_response.dart';

import '../models/movie.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'en-US';
  final String _page = '1';
  final Map<String, String> _headers = {
    'accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMWY1ZWY2YjAxMTRiYzliNDdlMjgwZTFmMmVkMWFhZSIsIm5iZiI6MTczMjEwNTM5MS4wNDE3MzQ3LCJzdWIiOiI2NzNkYzc2MTRlZTcyYjI3MmZlZjY4MDkiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.Pa1HFoDnlIerMESq689BzmQ6jhaj-JpKcnAXTWBj0c8'
  };

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    print('MoviesProvider');
    getOnDisplayMovies();
  }

  void getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/popular', {
      'language': _language,
      'page': _page,
    });

    // Await the http get response, then decode the json-formatted response.
    print('AAAAAAAAA');
    var response = await http.get(url, headers: _headers);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    onDisplayMovies = nowPlayingResponse.results;
    print('BBBBBBBBBB: ' + onDisplayMovies[0].title);
    notifyListeners();
  }
}
