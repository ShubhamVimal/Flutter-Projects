import 'package:flutter/material.dart';
import 'package:flutter_movies_app/model/movies/MovieCastModel.dart'
    as movieCast;
import 'package:flutter_movies_app/model/movies/MovieDetailsModel.dart';
import 'package:flutter_movies_app/model/movies/MovieSearchModel.dart'
    as movieSearchModel;
import 'package:flutter_movies_app/model/movies/MoviesModel.dart'
    as moviesModel;
import 'package:flutter_movies_app/model/movies/NowPlayingModel.dart'
    as nowPlaying;

import 'package:flutter_movies_app/services/GetMoviesTvShows.dart';

class MoviesProvider with ChangeNotifier {
  List<nowPlaying.Result> _nowPlayingMovies = [];

  List<moviesModel.Result> _popularLS = [];
  List<moviesModel.Result> _topRatedLS = [];
  List<moviesModel.Result> _upComingLS = [];
  List<movieSearchModel.Result> _movieSearchLS = [];
  List<movieCast.Cast> _movieCastLS = [];

  MovieDetailsModel _movieDetailsModel = MovieDetailsModel(
      adult: false,
      backdropPath: '',
      belongsToCollection: '',
      budget: 0,
      genres: [],
      homepage: '',
      id: 0,
      imdbId: '',
      originalLanguage: '',
      originalTitle: '',
      overview: '',
      popularity: 0.0,
      posterPath: '',
      productionCompanies: [],
      productionCountries: [],
      releaseDate: DateTime.tryParse(''),
      revenue: 0,
      runtime: 0,
      spokenLanguages: [],
      status: '',
      tagline: '',
      title: '',
      video: false,
      voteAverage: 0.0,
      voteCount: 0);

  bool _noMore = false;

  List<nowPlaying.Result> get getNowPlaying => [..._nowPlayingMovies];

  List<moviesModel.Result> get getPopularMovies => [..._popularLS];
  List<moviesModel.Result> get getTopRatedMovies => [..._topRatedLS];
  List<moviesModel.Result> get getUpComingMovies => [..._upComingLS];
  List<movieSearchModel.Result> get getMovieSearch => [..._movieSearchLS];
  List<movieCast.Cast> get getMovieCast => [..._movieCastLS];

  MovieDetailsModel get getMovieDetails => _movieDetailsModel;

  bool get noMore => _noMore;

  set setNoMore(bool value) => this._noMore = value;

  Future<void> getNowPlayingMovies({required String type}) async {
    try {
      nowPlaying.NowPlayingModel? nowPlayingModel =
          await GetMoviesTvShows.nowPlayingMovies(type: type, page: 1);
      if (nowPlayingModel != null) {
        List<nowPlaying.Result> temp = [];
        nowPlayingModel.results.forEach((result) {
          if (result.title.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _nowPlayingMovies = temp;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> popularMoviesData() async {
    try {
      moviesModel.MoviesModel? restMovies =
          await GetMoviesTvShows.getMovies(type: 'popular', page: 1);
      if (restMovies != null) {
        List<moviesModel.Result> temp = [];
        restMovies.results.forEach((result) {
          if (result.title.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _popularLS = temp;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> topRatedMoviesData() async {
    try {
      moviesModel.MoviesModel? restMovies =
          await GetMoviesTvShows.getMovies(type: 'top_rated', page: 1);
      if (restMovies != null) {
        List<moviesModel.Result> temp = [];
        restMovies.results.forEach((result) {
          if (result.title.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _topRatedLS = temp;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> upcomingMoviesData() async {
    try {
      moviesModel.MoviesModel? restMovies =
          await GetMoviesTvShows.getMovies(type: 'upcoming', page: 1);
      if (restMovies != null) {
        List<moviesModel.Result> temp = [];
        restMovies.results.forEach((result) {
          if (result.title.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _upComingLS = temp;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void addMoreNowPlaying({required int nextPage, required String type}) async {
    try {
      nowPlaying.NowPlayingModel? nowPlayingModel =
          await GetMoviesTvShows.nowPlayingMovies(page: nextPage, type: type);
      if (nowPlayingModel != null) {
        List<nowPlaying.Result> temp = [];
        nowPlayingModel.results.forEach((result) {
          if (result.title.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _nowPlayingMovies.addAll(temp);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void addMorePopular({required int nextPage}) async {
    try {
      moviesModel.MoviesModel? restMovies =
          await GetMoviesTvShows.getMovies(type: 'popular', page: nextPage);
      if (restMovies != null) {
        List<moviesModel.Result> temp = [];
        restMovies.results.forEach((result) {
          if (result.title.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _popularLS.addAll(temp);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void addMoreTopRated({required int nextPage}) async {
    try {
      moviesModel.MoviesModel? restMovies =
          await GetMoviesTvShows.getMovies(type: 'top_rated', page: nextPage);
      if (restMovies != null) {
        List<moviesModel.Result> temp = [];
        restMovies.results.forEach((result) {
          if (result.title.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _topRatedLS.addAll(temp);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void addMoreUpcoming({required int nextPage}) async {
    try {
      moviesModel.MoviesModel? restMovies =
          await GetMoviesTvShows.getMovies(type: 'upcoming', page: nextPage);
      if (restMovies != null) {
        List<moviesModel.Result> temp = [];
        restMovies.results.forEach((result) {
          if (result.title.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _upComingLS.addAll(temp);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> movieDetails({required int movieId}) async {
    try {
      MovieDetailsModel? movieDetailsModel =
          await GetMoviesTvShows.getMovieDetails(movieId: movieId);
      if (movieDetailsModel != null) {
        _movieDetailsModel = movieDetailsModel;
        movieCastLS(movieId: movieId);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> movieSearch({required String query}) async {
    try {
      movieSearchModel.MovieSearchModel? movieSearch =
          await GetMoviesTvShows.getSearchMovie(query: query, page: 1);
      if (movieSearch != null) {
        List<movieSearchModel.Result> temp = [];
        movieSearch.results.forEach((element) {
          if (element.title.isNotEmpty && element.overview.isNotEmpty) {
            temp.add(element);
          }
        });
        _movieSearchLS = temp;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> movieCastLS({required int movieId}) async {
    try {
      movieCast.MovieCastModel? movieCastls =
          await GetMoviesTvShows.getMovieCast(movieId: movieId);
      if (movieCastls != null) {
        _movieCastLS = movieCastls.cast;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  // Future<void> filterByGenre({required int genreId}) async {
  //   try {
  //     List<nowPlaying.Result> nowPlayingTemp = [];
  //     _nowPlayingMovies.forEach((element) {
  //       if (element.genreIds.contains(genreId)) nowPlayingTemp.add(element);
  //     });
  //     List<moviesModel.Result> popularTemp = [];
  //     _popularLS.forEach((element) {
  //       if (element.genreIds.contains(genreId)) popularTemp.add(element);
  //     });
  //     List<moviesModel.Result> topRatedTemp = [];
  //     _topRatedLS.forEach((element) {
  //       if (element.genreIds.contains(genreId)) topRatedTemp.add(element);
  //     });
  //     List<moviesModel.Result> upcomingTemp = [];
  //     _upComingLS.forEach((element) {
  //       if (element.genreIds.contains(genreId)) upcomingTemp.add(element);
  //     });
  //     _nowPlayingMovies = nowPlayingTemp;
  //     _popularLS = popularTemp;
  //     _topRatedLS = topRatedTemp;
  //     _upComingLS = upcomingTemp;
  //     notifyListeners();
  //   } catch (e, s) {
  //     print(e);
  //     print(s);
  //   }
  // }
}
