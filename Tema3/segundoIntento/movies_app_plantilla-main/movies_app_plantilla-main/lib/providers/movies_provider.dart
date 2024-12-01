import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier{
  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '8567c02a3be956cc5bdb08210a5b168e';
  String _language = 'es-ES';
  String _page = '1';

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    print("Provider iniciao");
    getOnDisplayMovies();
    //getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url =
      Uri.https(_baseUrl, '3/movie/now_playing', {
        'api_key': _apiKey,
        'language': _language,
        'page': _page
      });

  // Await the http get response, then decode the json-formatted response.
  final result = await http.get(url);

  final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

  onDisplayMovie = nowPlayingResponse.results;

  notifyListeners();
  }

  getPopularMovies() async {
     var url =
      Uri.https(_baseUrl, '3/movie/popular', {
        'api_key': _apiKey,
        'language': _language,
        'page': _page
      });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final popularResponse = PopularResponse.fromJson(result.body);

    popularMovies = popularResponse.results.cast<Movie>();

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url =
      Uri.https(_baseUrl, '3/movie/$idMovie/credits', {
        'api_key': _apiKey,
        'language': _language
      });

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final creditsResponse = CreditResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
