import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:my_movie/src/core/failure.dart';
import 'package:my_movie/src/features/movie_flow/movie_repository.dart';

import 'genre/genre.dart';
import 'result/movie.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return TMDBMovieService(movieRepository);
});

abstract class MovieService {
  Future<Result<List<Genre>, Failure>> getGenres();

  Future<Result<Movie, Failure>> getRecommendedMovie(
      int rating, int yearsBack, List<Genre> genres,
      [DateTime? yearsBackFromDate]);
}

class TMDBMovieService implements MovieService {
  final MovieRepository _movieRepository;

  TMDBMovieService(this._movieRepository);

  @override
  Future<Result<List<Genre>, Failure>> getGenres() async {
    try {
      final genreEntities = await _movieRepository.getMovieGenres();
      final genres = genreEntities.map((e) => Genre.fromEntity(e)).toList();
      return Success(genres);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Future<Result<Movie, Failure>> getRecommendedMovie(
      int rating, int yearsBack, List<Genre> genres,
      [DateTime? yearsBackFromDate]) async {
    final date = yearsBackFromDate ?? DateTime.now();
    final year = date.year - yearsBack;
    final genreIds = genres.map((e) => e.id).toList().join(',');

    try {
      final movieEntities = await _movieRepository.getRecommendedMovies(
          rating.toDouble(), '$year-01-01', genreIds);
      final movies =
          movieEntities.map((e) => Movie.fromEntity(e, genres)).toList();

      if (movies.isEmpty) {
        return Error(Failure(message: 'No movies found'));
      }

      final random = Random();
      final randomMovie = movies[random.nextInt(movies.length)];
      return Success(randomMovie);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }
}
