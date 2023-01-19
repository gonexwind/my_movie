import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String title;
  final String overview;
  final num voteAverage;
  final List<int> genreIds;
  final String releaseDate;
  final String? backdropPath;
  final String? posterPath;

  const MovieEntity({
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genreIds,
    required this.releaseDate,
    this.backdropPath,
    this.posterPath,
  });

  factory MovieEntity.fromMap(Map<String, dynamic> map) {
    return MovieEntity(
      title: map['title'],
      overview: map['overview'],
      voteAverage: map['vote_average'],
      genreIds: List.from(map['genre_ids']),
      releaseDate: map['release_date'],
      backdropPath: map['backdrop_path'],
      posterPath: map['poster_path'],
    );
  }

  @override
  List<Object?> get props => [
        title,
        overview,
        voteAverage,
        genreIds,
        releaseDate,
        backdropPath,
        posterPath,
      ];
}
