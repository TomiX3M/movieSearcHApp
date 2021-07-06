import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:movie_app/movie.dart';

class HttpHelper {
  final String urlKey = 'api_key=2bf32619cabd99cdbae1f5b70605724f';
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlUpcoming = '/upcoming?';
  final String urlLanguage = '&language=en-US';
  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=2bf32619cabd99cdbae1f5b70605724f&query=';

  Future<List> findMovies(String title) async {
    final String query = urlSearchBase + title;
    http.Response response = await http.get(Uri.parse(query));
    if (response.statusCode == HttpStatus.ok) {
      String responseBody = response.body;
      final jsonResponse = jsonDecode(responseBody);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((e) => Movie.fromJson(e)).toList();
      return movies;
    } else {
      return [];
    }
  }

  Future<List> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLanguage;

    http.Response result = await http.get(Uri.parse(upcoming));
    if (result.statusCode == HttpStatus.ok) {
      String responseBody = result.body;
      final jsonResponse = json.decode(responseBody);
      final movies = jsonResponse['results'];
      List moviesList = movies.map((i) => Movie.fromJson(i)).toList();
      return moviesList;
    } else {
      return [];
    }
  }
}
