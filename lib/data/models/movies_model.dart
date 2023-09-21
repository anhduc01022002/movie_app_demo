import 'package:movie_app/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity{
  final bool adult;
  final String backdropPath;
  final int id;
  final String title;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String mediaType;
  final List<int> genreIds;
  final double popularity;
  final String releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieModel(
      {required this.adult,
        required this.backdropPath,
        required this.id,
        required this.title,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.posterPath,
        required this.mediaType,
        required this.genreIds,
        required this.popularity,
        required this.releaseDate,
        required this.video,
        required this.voteAverage,
        required this.voteCount
      }) : super(
              id: id,
              title: title,
              backdropPath: backdropPath,
              posterPath: posterPath,
              releaseDate: releaseDate,
              voteAverage: voteAverage,
              overview: overview,

            );


  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      adult : json['adult'] as bool? ?? false,
      backdropPath : json['backdrop_path'] as String? ?? '',
      id : json['id'] as int? ?? 0,
      title : json['title'] as String? ?? '',
      originalLanguage : json['original_language'] as String? ?? '',
      originalTitle : json['original_title'] as String? ?? '',
      overview : json['overview'] as String? ?? '',
      posterPath : json['poster_path'] as String? ?? '',
      mediaType : json['media_type'] as String? ?? '',
      genreIds : (json['genre_ids'] as List<dynamic>?)?.cast<int>() ?? [],
      popularity : (json['popularity'] as num?)?.toDouble() ?? 0.0,
      releaseDate : json['release_date'] as String? ?? '',
      video : json['video'] as bool? ?? false,
      voteAverage : (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount : json['vote_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['id'] = id;
    data['title'] = title;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['poster_path'] = posterPath;
    data['media_type'] = mediaType;
    data['genre_ids'] = genreIds;
    data['popularity'] = popularity;
    data['release_date'] = releaseDate;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}