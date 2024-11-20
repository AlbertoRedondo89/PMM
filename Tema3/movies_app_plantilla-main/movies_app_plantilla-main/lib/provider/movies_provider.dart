import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'en_US';
  final String _page = '1';
  final String _apiKey = '8567c02a3be956cc5bdb08210a5b168e';
  final String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NTY3YzAyYTNiZTk1NmNjNWJkYjA4MjEwYTViMTY4ZSIsIm5iZiI6MTczMTkyNTY4MC4zMzAyNDkzLCJzdWIiOiI2NzNiMTNhZjgzYjY2NmE0ZTlhMmI2YTAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.NboQlCljzZMO7V9eN3FKXyziEo0c_nzrIEiKkhdeTd4';

  final Map<String, String> header = {
    'accept': 'application/json',
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NTY3YzAyYTNiZTk1NmNjNWJkYjA4MjEwYTViMTY4ZSIsIm5iZiI6MTczMTkyNTY4MC4zMzAyNDkzLCJzdWIiOiI2NzNiMTNhZjgzYjY2NmE0ZTlhMmI2YTAiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.NboQlCljzZMO7V9eN3FKXyziEo0c_nzrIEiKkhdeTd4'
  };

  MoviesProvider() {
    print("Movies Provider");
  }

  void getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '/3/movie/now_playing',
        {'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var itemCount = jsonResponse['results'].length;
      print('Number of Movies about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
