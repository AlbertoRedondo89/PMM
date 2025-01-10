import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubik_app/models/newsresponse.dart';
import 'package:cubik_app/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'newsstate.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  final String _apiKey = '74b85f61f06b449f8f37474e45c74902';
  final String _baseUrl = 'https://newsapi.org/v2/everything?q=animal&language=es';

  Future<void> fetchNews() async {
    emit(NewsLoading());

    try {
      final url = Uri.parse('$_baseUrl?country=us&apiKey=$_apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final newsResponse = NewsResponse.fromJson(response.body);
        emit(NewsLoaded(newsResponse.articles));
      } else {
        emit(NewsError('Error al cargar las noticias'));
      }
    } catch (e) {
      emit(NewsError('Error de conexión: ${e.toString()}'));
    }
  }
}
