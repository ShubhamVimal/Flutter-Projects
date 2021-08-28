import 'package:flutter_movies_app/model/movies/MovieCastModel.dart';
import 'package:flutter_movies_app/model/movies/MovieDetailsModel.dart';
import 'package:flutter_movies_app/model/movies/MovieSearchModel.dart';
import 'package:flutter_movies_app/model/movies/MoviesModel.dart';
import 'package:flutter_movies_app/model/movies/NowPlayingModel.dart';
import 'package:flutter_movies_app/model/tv/TvShowCastModel.dart';
import 'package:flutter_movies_app/model/tv/TvShowDetailsModelNew.dart';
import 'package:flutter_movies_app/model/tv/TvShowSearchModel.dart';
import 'package:flutter_movies_app/model/tv/TvShowsModel.dart';
import 'package:http/http.dart' as http;

class GetMoviesTvShows {
  static const String API_KEY = '5a2c86428f06c1fab33fa9379b2da6a4';

  static Future<MoviesModel?> getMovies(
      {required String type, required int page}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$type?api_key=$API_KEY&language=en-US&page=$page'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return moviesModelFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<NowPlayingModel?> nowPlayingMovies(
      {required String type, required int page}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$type?api_key=$API_KEY&language=en-US&page=$page'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return nowPlayingModelFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<TvShowsModel?> getTvShows(
      {required String type, required int page}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/tv/$type?api_key=$API_KEY&language=en-US&page=$page'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return tvShowsModelFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<MovieDetailsModel?> getMovieDetails(
      {required int movieId}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId?api_key=$API_KEY&language=en-US'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return movieDetailsModelFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<TvShowDetailsModelNew?> getTvShowDetails(
      {required int tvId}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/tv/$tvId?api_key=$API_KEY&language=en-US'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return tvShowDetailsModelNewFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<MovieSearchModel?> getSearchMovie(
      {required String query, required int page}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&language=en-US&query=$query&page=$page&include_adult=false'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return movieSearchModelFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<TvShowSearchModel?> getSeacrhTV(
      {required String query, required int page}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/tv?api_key=$API_KEY&language=en-US&page=$page&query=$query&include_adult=false'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return tvShowSearchModelFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<MovieCastModel?> getMovieCast({required int movieId}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$API_KEY&language=en-US'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return movieCastModelFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  static Future<TvShowCastModel?> getTvShowCast({required int tvId}) async {
    try {
      var response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/tv/$tvId/credits?api_key=$API_KEY&language=en-US'));
      if (response.statusCode == 200) {
        var jsonData = response.body;

        return tvShowCastModelFromJson(jsonData);
      } else {
        //Show error
        return null;
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
