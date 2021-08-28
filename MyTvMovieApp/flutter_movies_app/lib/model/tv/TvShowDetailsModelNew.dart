// To parse this JSON data, do
//
//     final tvShowDetailsModelNew = tvShowDetailsModelNewFromJson(jsonString);

import 'dart:convert';

TvShowDetailsModelNew tvShowDetailsModelNewFromJson(String str) =>
    TvShowDetailsModelNew.fromJson(json.decode(str));

String tvShowDetailsModelNewToJson(TvShowDetailsModelNew data) =>
    json.encode(data.toJson());

class TvShowDetailsModelNew {
  TvShowDetailsModelNew({
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  dynamic backdropPath;
  List<dynamic> createdBy;
  List<int> episodeRunTime;
  DateTime? firstAirDate;
  List<Genre> genres;
  String homepage;
  int id;
  bool inProduction;
  List<String> languages;
  DateTime? lastAirDate;
  TEpisodeToAir lastEpisodeToAir;
  String name;
  TEpisodeToAir nextEpisodeToAir;
  List<Network> networks;
  int numberOfEpisodes;
  int numberOfSeasons;
  List<String> originCountry;
  String originalLanguage;
  String originalName;
  String overview;
  double popularity;
  dynamic posterPath;
  List<ProductionCompany> productionCompanies;
  List<ProductionCountry> productionCountries;
  List<Season> seasons;
  List<SpokenLanguage> spokenLanguages;
  String status;
  String tagline;
  String type;
  double voteAverage;
  int voteCount;

  factory TvShowDetailsModelNew.fromJson(Map<String, dynamic> json) =>
      TvShowDetailsModelNew(
        backdropPath: json["backdrop_path"],
        createdBy: json["created_by"] == null
            ? []
            : List<dynamic>.from(json["created_by"].map((x) => x)),
        episodeRunTime: json["episode_run_time"] == null
            ? []
            : List<int>.from(json["episode_run_time"].map((x) => x)),
        firstAirDate: json["first_air_date"] == null
            ? DateTime.tryParse('')
            : DateTime.parse(json["first_air_date"]),
        genres: json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        homepage: json["homepage"] == null ? '' : json["homepage"],
        id: json["id"] == null ? 0 : json["id"],
        inProduction:
            json["in_production"] == null ? false : json["in_production"],
        languages: json["languages"] == null
            ? []
            : List<String>.from(json["languages"].map((x) => x)),
        lastAirDate: json["last_air_date"] == null
            ? DateTime.tryParse('')
            : DateTime.parse(json["last_air_date"]),
        lastEpisodeToAir: json["last_episode_to_air"] == null
            ? TEpisodeToAir(
                airDate: DateTime.tryParse(''),
                episodeNumber: 0,
                id: 0,
                name: '',
                overview: '',
                productionCode: '',
                seasonNumber: 0,
                stillPath: '',
                voteAverage: 0,
                voteCount: 0)
            : TEpisodeToAir.fromJson(json["last_episode_to_air"]),
        name: json["name"] == null ? null : json["name"],
        nextEpisodeToAir: json["next_episode_to_air"] == null
            ? TEpisodeToAir(
                airDate: DateTime.tryParse(''),
                episodeNumber: 0,
                id: 0,
                name: '',
                overview: '',
                productionCode: '',
                seasonNumber: 0,
                stillPath: '',
                voteAverage: 0.0,
                voteCount: 0)
            : TEpisodeToAir.fromJson(json["next_episode_to_air"]),
        networks: json["networks"] == null
            ? []
            : List<Network>.from(
                json["networks"].map((x) => Network.fromJson(x))),
        numberOfEpisodes:
            json["number_of_episodes"] == null ? 0 : json["number_of_episodes"],
        numberOfSeasons:
            json["number_of_seasons"] == null ? 0 : json["number_of_seasons"],
        originCountry: json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage:
            json["original_language"] == null ? '' : json["original_language"],
        originalName:
            json["original_name"] == null ? '' : json["original_name"],
        overview: json["overview"] == null ? '' : json["overview"],
        popularity:
            json["popularity"] == null ? null : json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: json["production_companies"] == null
            ? []
            : List<ProductionCompany>.from(json["production_companies"]
                .map((x) => ProductionCompany.fromJson(x))),
        productionCountries: json["production_countries"] == null
            ? []
            : List<ProductionCountry>.from(json["production_countries"]
                .map((x) => ProductionCountry.fromJson(x))),
        seasons: json["seasons"] == null
            ? []
            : List<Season>.from(json["seasons"].map((x) => Season.fromJson(x))),
        spokenLanguages: json["spoken_languages"] == null
            ? []
            : List<SpokenLanguage>.from(json["spoken_languages"]
                .map((x) => SpokenLanguage.fromJson(x))),
        status: json["status"] == null ? '' : json["status"],
        tagline: json["tagline"] == null ? '' : json["tagline"],
        type: json["type"] == null ? '' : json["type"],
        voteAverage: json["vote_average"] == null ? 0.0 : json["vote_average"],
        voteCount: json["vote_count"] == null ? 0 : json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "created_by": createdBy == null
            ? null
            : List<dynamic>.from(createdBy.map((x) => x)),
        "episode_run_time": episodeRunTime == null
            ? null
            : List<dynamic>.from(episodeRunTime.map((x) => x)),
        "first_air_date": firstAirDate == null
            ? null
            : "${firstAirDate!.year.toString().padLeft(4, '0')}-${firstAirDate!.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres.map((x) => x.toJson())),
        "homepage": homepage == null ? null : homepage,
        "id": id == null ? null : id,
        "in_production": inProduction == null ? null : inProduction,
        "languages": languages == null
            ? null
            : List<dynamic>.from(languages.map((x) => x)),
        "last_air_date": lastAirDate == null
            ? null
            : "${lastAirDate!.year.toString().padLeft(4, '0')}-${lastAirDate!.month.toString().padLeft(2, '0')}-${lastAirDate!.day.toString().padLeft(2, '0')}",
        "last_episode_to_air":
            lastEpisodeToAir == null ? null : lastEpisodeToAir.toJson(),
        "name": name == null ? null : name,
        "next_episode_to_air":
            nextEpisodeToAir == null ? null : nextEpisodeToAir.toJson(),
        "networks": networks == null
            ? null
            : List<dynamic>.from(networks.map((x) => x.toJson())),
        "number_of_episodes":
            numberOfEpisodes == null ? null : numberOfEpisodes,
        "number_of_seasons": numberOfSeasons == null ? null : numberOfSeasons,
        "origin_country": originCountry == null
            ? null
            : List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage == null ? null : originalLanguage,
        "original_name": originalName == null ? null : originalName,
        "overview": overview == null ? null : overview,
        "popularity": popularity == null ? null : popularity,
        "poster_path": posterPath,
        "production_companies": productionCompanies == null
            ? null
            : List<dynamic>.from(productionCompanies.map((x) => x)),
        "production_countries": productionCountries == null
            ? null
            : List<dynamic>.from(productionCountries.map((x) => x.toJson())),
        "seasons": seasons == null
            ? null
            : List<dynamic>.from(seasons.map((x) => x.toJson())),
        "spoken_languages": spokenLanguages == null
            ? null
            : List<dynamic>.from(spokenLanguages.map((x) => x.toJson())),
        "status": status == null ? null : status,
        "tagline": tagline == null ? null : tagline,
        "type": type == null ? null : type,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
      };
}

class Genre {
  Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? '' : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class TEpisodeToAir {
  TEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  DateTime? airDate;
  int episodeNumber;
  int id;
  String name;
  String overview;
  String productionCode;
  int seasonNumber;
  dynamic stillPath;
  double voteAverage;
  int voteCount;

  factory TEpisodeToAir.fromJson(Map<String, dynamic> json) => TEpisodeToAir(
        airDate: json["air_date"] == null
            ? DateTime.parse('')
            : DateTime.parse(json["air_date"]),
        episodeNumber:
            json["episode_number"] == null ? 0 : json["episode_number"],
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? '' : json["name"],
        overview: json["overview"] == null ? '' : json["overview"],
        productionCode:
            json["production_code"] == null ? '' : json["production_code"],
        seasonNumber: json["season_number"] == null ? 0 : json["season_number"],
        stillPath: json["still_path"] == null ? '' : json["still_path"],
        voteAverage: json["vote_average"] == null ? 0.0 : json["vote_average"],
        voteCount: json["vote_count"] == null ? 0 : json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate == null
            ? null
            : "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_number": episodeNumber == null ? null : episodeNumber,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "overview": overview == null ? null : overview,
        "production_code": productionCode == null ? null : productionCode,
        "season_number": seasonNumber == null ? null : seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage == null ? null : voteAverage,
        "vote_count": voteCount == null ? null : voteCount,
      };
}

class Network {
  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

  String name;
  int id;
  String logoPath;
  String originCountry;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        name: json["name"] == null ? '' : json["name"],
        id: json["id"] == null ? 0 : json["id"],
        logoPath: json["logo_path"] == null ? '' : json["logo_path"],
        originCountry:
            json["origin_country"] == null ? '' : json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "logo_path": logoPath == null ? null : logoPath,
        "origin_country": originCountry == null ? null : originCountry,
      };
}

class ProductionCompany {
  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  int id;
  String logoPath;
  String name;
  String originCountry;

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"] == null ? 0 : json["id"],
        logoPath: json["logo_path"] == null ? '' : json["logo_path"],
        name: json["name"] == null ? '' : json["name"],
        originCountry:
            json["origin_country"] == null ? '' : json["origin_country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "logo_path": logoPath == null ? null : logoPath,
        "name": name == null ? null : name,
        "origin_country": originCountry == null ? null : originCountry,
      };
}

class ProductionCountry {
  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  String iso31661;
  String name;

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        iso31661: json["iso_3166_1"] == null ? '' : json["iso_3166_1"],
        name: json["name"] == null ? '' : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1": iso31661 == null ? null : iso31661,
        "name": name == null ? null : name,
      };
}

class Season {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  DateTime? airDate;
  int episodeCount;
  int id;
  String name;
  String overview;
  dynamic posterPath;
  int seasonNumber;

  factory Season.fromJson(Map<String, dynamic> json) => Season(
        airDate: json["air_date"] == null
            ? DateTime.tryParse('')
            : DateTime.parse(json["air_date"]),
        episodeCount: json["episode_count"] == null ? 0 : json["episode_count"],
        id: json["id"] == null ? 0 : json["id"],
        name: json["name"] == null ? '' : json["name"],
        overview: json["overview"] == null ? '' : json["overview"],
        posterPath: json["poster_path"] == null ? '' : json["poster_path"],
        seasonNumber: json["season_number"] == null ? 0 : json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate == null
            ? null
            : "${airDate!.year.toString().padLeft(4, '0')}-${airDate!.month.toString().padLeft(2, '0')}-${airDate!.day.toString().padLeft(2, '0')}",
        "episode_count": episodeCount == null ? null : episodeCount,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "overview": overview == null ? null : overview,
        "poster_path": posterPath,
        "season_number": seasonNumber == null ? null : seasonNumber,
      };
}

class SpokenLanguage {
  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  String englishName;
  String iso6391;
  String name;

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
        englishName: json["english_name"] == null ? '' : json["english_name"],
        iso6391: json["iso_639_1"] == null ? '' : json["iso_639_1"],
        name: json["name"] == null ? '' : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "english_name": englishName == null ? null : englishName,
        "iso_639_1": iso6391 == null ? null : iso6391,
        "name": name == null ? null : name,
      };
}
