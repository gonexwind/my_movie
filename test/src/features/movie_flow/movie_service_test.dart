import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_movie/src/core/failure.dart';
import 'package:my_movie/src/features/movie_flow/genre/genre.dart';
import 'package:my_movie/src/features/movie_flow/genre/genre_entity.dart';
import 'package:my_movie/src/features/movie_flow/movie_repository.dart';
import 'package:my_movie/src/features/movie_flow/movie_service.dart';
import 'package:my_movie/src/features/movie_flow/result/movie.dart';
import 'package:my_movie/src/features/movie_flow/result/movie_entity.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
  });

  test('Should return success When getting GenreEntities', () async {
    when(() => mockMovieRepository.getMovieGenres()).thenAnswer((invocation) =>
        Future.value([const GenreEntity(id: 0, name: 'Animation')]));
    final movieService = TMDBMovieService(mockMovieRepository);
    final result = await movieService.getGenres();
    expect(result.tryGetSuccess(), [const Genre(name: 'Animation')]);
  });

  test('Should return failure When getting GenreEntities', () async {
    when(() => mockMovieRepository.getMovieGenres()).thenThrow(
        Failure(message: 'No internet', exception: const SocketException('')));
    final movieService = TMDBMovieService(mockMovieRepository);
    final result = await movieService.getGenres();
    expect(result.tryGetError()?.exception, isA<SocketException>());
  });

  test('Should return success When getting MovieEntity', () async {
    const genre = Genre(name: 'Animation', id: 1, isSelected: true);
    const movieEntity = MovieEntity(
      title: 'Naruto',
      overview: 'A little kid who dreamed become Hokage',
      voteAverage: 10,
      genreIds: [1],
      releaseDate: '2002-02-02',
    );

    when(() => mockMovieRepository.getRecommendedMovies(any(), any(), any()))
        .thenAnswer((invocation) => Future.value([movieEntity]));

    final movieService = TMDBMovieService(mockMovieRepository);
    final result =
        await movieService.getRecommendedMovie(5, 20, [genre], DateTime(2023));
    final movie = result.tryGetSuccess();

    expect(
      movie,
      Movie(
        title: movieEntity.title,
        overview: movieEntity.overview,
        voteAverage: movieEntity.voteAverage,
        genres: const [genre],
        releaseDate: movieEntity.releaseDate,
      ),
    );
  });

  test('Should return failure When getting MovieEntity', () async {
    const genre = Genre(name: 'Animation', id: 1, isSelected: true);

    when(() => mockMovieRepository.getRecommendedMovies(any(), any(), any()))
        .thenThrow(Failure(
            message: 'No internet', exception: const SocketException('')));

    final movieService = TMDBMovieService(mockMovieRepository);

    final result =
        await movieService.getRecommendedMovie(5, 20, [genre], DateTime(2023));

    expect(result.tryGetError()?.exception, isA<SocketException>());
  });
}
