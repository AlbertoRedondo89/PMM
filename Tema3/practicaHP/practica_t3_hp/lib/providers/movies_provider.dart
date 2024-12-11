/*
class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '8567c02a3be956cc5bdb08210a5b168e';
  final String _language = 'es-ES';
  final String _page = '1';

  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> casting = {};

  MoviesProvider() {
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(result.body);

    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': _page});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final popularResponse = PopularResponse.fromJson(result.body);

    popularMovies = popularResponse.results;

    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int idMovie) async {
    var url = Uri.https(_baseUrl, '3/movie/$idMovie/credits',
        {'api_key': _apiKey, 'language': _language});

    // Await the http get response, then decode the json-formatted response.
    final result = await http.get(url);

    final creditsResponse = CreditResponse.fromJson(result.body);

    casting[idMovie] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
*/