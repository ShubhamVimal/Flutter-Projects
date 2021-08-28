import 'package:flutter/material.dart';
import 'package:flutter_movies_app/model/tv/TvShowCastModel.dart' as tvCast;

import 'package:flutter_movies_app/model/tv/TvShowDetailsModelNew.dart';
import 'package:flutter_movies_app/model/tv/TvShowsModel.dart' as tvShowsModel;
import 'package:flutter_movies_app/services/GetMoviesTvShows.dart';
import 'package:flutter_movies_app/model/tv/TvShowSearchModel.dart'
    as tvShowSearchModel;

class TvShowsProvider with ChangeNotifier {
  List<tvShowsModel.Result> _airingTodayLS = [];
  List<tvShowsModel.Result> _onTheAirLS = [];
  List<tvShowsModel.Result> _topRatedLS = [];
  List<tvShowsModel.Result> _popularLS = [];
  List<tvShowSearchModel.Result> _tvSearchLS = [];
  List<tvCast.Cast> _tvCastLS = [];

  TvShowDetailsModelNew _tvShowDetailsModelNew = TvShowDetailsModelNew(
      backdropPath: '',
      createdBy: [],
      episodeRunTime: [],
      firstAirDate: DateTime.tryParse(''),
      genres: [],
      homepage: '',
      id: 0,
      inProduction: false,
      languages: [],
      lastAirDate: DateTime.tryParse(''),
      lastEpisodeToAir: TEpisodeToAir(
          airDate: DateTime.tryParse(''),
          episodeNumber: 0,
          id: 0,
          name: '',
          overview: '',
          productionCode: '',
          seasonNumber: 0,
          stillPath: '',
          voteAverage: 0.0,
          voteCount: 0),
      name: '',
      nextEpisodeToAir: TEpisodeToAir(
          airDate: DateTime.tryParse(''),
          episodeNumber: 0,
          id: 0,
          name: '',
          overview: '',
          productionCode: '',
          seasonNumber: 0,
          stillPath: '',
          voteAverage: 0.0,
          voteCount: 0),
      networks: [],
      numberOfEpisodes: 0,
      numberOfSeasons: 0,
      originCountry: [],
      originalLanguage: '',
      originalName: '',
      overview: '',
      popularity: 0,
      posterPath: '',
      productionCompanies: [],
      productionCountries: [],
      seasons: [],
      spokenLanguages: [],
      status: '',
      tagline: '',
      type: '',
      voteAverage: 0.0,
      voteCount: 0);

  bool _noMore = false;

  List<tvShowsModel.Result> get airingTodayLS => [..._airingTodayLS];
  List<tvShowsModel.Result> get onTheAirLS => [..._onTheAirLS];
  List<tvShowsModel.Result> get topRatedLS => [..._topRatedLS];
  List<tvShowsModel.Result> get popularLS => [..._popularLS];
  List<tvShowSearchModel.Result> get getTvSearch => [..._tvSearchLS];
  TvShowDetailsModelNew get getTvShowDetails => _tvShowDetailsModelNew;
  List<tvCast.Cast> get getTvCastLS => [..._tvCastLS];

  bool get noMore => _noMore;
  set setNoMore(bool value) => this._noMore = value;

  Future<void> getAiringToday() async {
    try {
      tvShowsModel.TvShowsModel? tvModel =
          await GetMoviesTvShows.getTvShows(type: 'airing_today', page: 1);
      if (tvModel != null) {
        List<tvShowsModel.Result> temp = [];
        tvModel.results.forEach((result) {
          if (result.name.isNotEmpty && result.overview.isNotEmpty) {
            temp.add(result);
          }
        });
        _airingTodayLS = temp;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> getOnTheAir() async {
    try {
      tvShowsModel.TvShowsModel? tvModel =
          await GetMoviesTvShows.getTvShows(type: 'on_the_air', page: 1);
      if (tvModel != null) {
        List<tvShowsModel.Result> temp = [];
        tvModel.results.forEach((result) {
          if (result.name.isNotEmpty &&
              result.overview.isNotEmpty &&
              result.backdropPath.isNotEmpty) {
            temp.add(result);
          }
        });
        _onTheAirLS = temp;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> getTopRated() async {
    try {
      tvShowsModel.TvShowsModel? tvModel =
          await GetMoviesTvShows.getTvShows(type: 'top_rated', page: 1);
      if (tvModel != null) {
        List<tvShowsModel.Result> temp = [];
        tvModel.results.forEach((result) {
          if (result.name.isNotEmpty && result.overview.isNotEmpty) {
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

  Future<void> getPopular() async {
    try {
      tvShowsModel.TvShowsModel? tvModel =
          await GetMoviesTvShows.getTvShows(type: 'popular', page: 1);
      if (tvModel != null) {
        List<tvShowsModel.Result> temp = [];
        tvModel.results.forEach((result) {
          if (result.name.isNotEmpty && result.overview.isNotEmpty) {
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

  void addMoreAiringToday({required int nextPage}) async {
    try {
      tvShowsModel.TvShowsModel? tvModel = await GetMoviesTvShows.getTvShows(
          type: 'airing_today', page: nextPage);
      if (tvModel != null) {
        List<tvShowsModel.Result> temp = [];
        tvModel.results.forEach((result) {
          if (result.name.isNotEmpty &&
              result.overview.isNotEmpty &&
              result.genreIds.isNotEmpty &&
              result.backdropPath.isNotEmpty) {
            temp.add(result);
          }
        });
        // _tvShowsLS.addAll(temp);
        _airingTodayLS.addAll(temp);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void addMoreOnTheAir({required int nextPage}) async {
    try {
      tvShowsModel.TvShowsModel? tvModel =
          await GetMoviesTvShows.getTvShows(type: 'on_the_air', page: nextPage);
      if (tvModel != null) {
        List<tvShowsModel.Result> temp = [];
        tvModel.results.forEach((result) {
          if (result.name.isNotEmpty &&
              result.overview.isNotEmpty &&
              result.genreIds.isNotEmpty &&
              result.backdropPath.isNotEmpty) {
            temp.add(result);
          }
        });
        // _tvShowsLS.addAll(temp);
        _onTheAirLS.addAll(temp);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void addMorePopularTv({required int nextPage}) async {
    try {
      tvShowsModel.TvShowsModel? tvModel =
          await GetMoviesTvShows.getTvShows(type: 'popular', page: nextPage);
      if (tvModel != null) {
        List<tvShowsModel.Result> temp = [];
        tvModel.results.forEach((result) {
          if (result.name.isNotEmpty &&
              result.overview.isNotEmpty &&
              result.genreIds.isNotEmpty &&
              result.backdropPath.isNotEmpty) {
            temp.add(result);
          }
        });
        // _tvShowsLS.addAll(temp);
        _popularLS.addAll(temp);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  void addMoreTopRatedTv({required int nextPage}) async {
    try {
      tvShowsModel.TvShowsModel? tvModel =
          await GetMoviesTvShows.getTvShows(type: 'top_rated', page: nextPage);
      if (tvModel != null) {
        List<tvShowsModel.Result> temp = [];
        tvModel.results.forEach((result) {
          if (result.name.isNotEmpty &&
              result.overview.isNotEmpty &&
              result.genreIds.isNotEmpty &&
              result.backdropPath.isNotEmpty) {
            temp.add(result);
          }
        });
        // _tvShowsLS.addAll(temp);
        _topRatedLS.addAll(temp);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> tvShowDetails({required int tvId}) async {
    try {
      TvShowDetailsModelNew? tvShowDetailsModel =
          await GetMoviesTvShows.getTvShowDetails(tvId: tvId);
      if (tvShowDetailsModel != null) {
        _tvShowDetailsModelNew = tvShowDetailsModel;
        tvCastLS(tvId: tvId);
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> tvSearch({required String query}) async {
    try {
      tvShowSearchModel.TvShowSearchModel? tvShowSearch =
          await GetMoviesTvShows.getSeacrhTV(query: query, page: 1);
      if (tvShowSearch != null) {
        List<tvShowSearchModel.Result> temp = [];
        tvShowSearch.results.forEach((element) {
          if (element.name.isNotEmpty && element.overview.isNotEmpty) {
            temp.add(element);
          }
        });
        _tvSearchLS = temp;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> tvCastLS({required int tvId}) async {
    try {
      tvCast.TvShowCastModel? tvShowCastModel =
          await GetMoviesTvShows.getTvShowCast(tvId: tvId);
      if (tvShowCastModel != null) {
        _tvCastLS = tvShowCastModel.cast;
        notifyListeners();
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
