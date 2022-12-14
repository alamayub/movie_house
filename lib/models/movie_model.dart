class MovieModel {
  final int id;
  final bool adult;
  final String? backdropPath;
  final List<dynamic>? genreIds;
  final String? originalLanguage;
  final String? originalName;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String? releaseDate;
  final String? name;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final String? mediaType;
  final List<dynamic>? originCountry;

  // final Map<String, dynamic>? belongsToCollection;
  final int? budget;
  final String? homepage;
  final String? imdbId;
  // final List<dynamic>? productionCompanies;
  // final List<String>? productionCountries;
  final int? revenue;
  final int? runtime;
  // final List<dynamic>? spokenLanguages;
  final String? status;
  final String? tagline;

  final int? gender;
  final String? knownForDepartment;
  final String? profilePath;

  MovieModel({
    required this.id,
    required this.adult,
    this.backdropPath,
    this.genreIds,
    this.originalLanguage,
    this.originalName,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.releaseDate,
    this.name,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.mediaType,
    this.originCountry,
    // this.belongsToCollection,
    this.budget,
    this.homepage,
    this.imdbId,
    // this.productionCompanies,
    // this.productionCountries,
    this.revenue,
    this.runtime,
    // this.spokenLanguages,
    this.status,
    this.tagline,

    this.gender,
    this.knownForDepartment,
    this.profilePath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: json['genre_ids'],
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      originalTitle: json['original_title'],
      overview: json['overview'] ?? '',
      popularity: json['popularity'] != null ? json['popularity'].toDouble() : 0,
      posterPath: json['poster_path'],
      firstAirDate: json['first_air_date'],
      releaseDate: json['release_date'],
      name: json['name'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'] != null ? json['vote_average'].toDouble() : 0,
      voteCount: json['vote_count'],
      mediaType: json['media_type'],
      originCountry: json['origin_country'],
      // belongsToCollection: json['belongs_to_collection'],
      budget: json['budget'],
      homepage: json['homepage'],
      imdbId: json['imdb_id'],
      // productionCompanies: json['production_companies'],
      // productionCountries: json['production_countries'],
      revenue: json['revenue'],
      runtime: json['runtime'],
      // spokenLanguages: json['spoken_languages'],
      status: json['status'],
      tagline: json['tagline'],
      gender: json['gender'],
      knownForDepartment: json['known_for_department'],
      profilePath: json['profile_path'],
    );
  }
}
