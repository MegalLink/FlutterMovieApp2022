import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/models.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'a3478cc0730a55fb49c7b630b7164c4b';
  final String _language = 'es_ES';

  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  getNowPlayingMovies() async {
    final jsonResponse = await _sendGetRequest('/3/movie/now_playing');
    final parsedResponse = NowPlayingResponse.fromJson(jsonResponse);
    nowPlayingMovies = parsedResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonResponse = await _sendGetRequest('/3/movie/popular');
    final popularResponse = PopularResponse.fromJson(jsonResponse);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<String> _sendGetRequest(String endpoint, [int page = 1]) async {
    var url = Uri.http(_baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': page});

    final response = await http.get(url);
    return response.body;
  }
}
