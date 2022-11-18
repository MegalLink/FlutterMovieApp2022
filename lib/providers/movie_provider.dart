import 'package:flutter/material.dart';
import 'package:flutter_movie_app/models/models.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = 'a3478cc0730a55fb49c7b630b7164c4b';
  final String _language = 'es_ES';

  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  getNowPlayingMovies() async {
    var url = Uri.http(_baseUrl, '/3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final parsedResponse = NowPlayingResponse.fromJson(response.body);
    nowPlayingMovies = parsedResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.http(_baseUrl, '/3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}