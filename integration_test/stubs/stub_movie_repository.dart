import 'package:my_movie/src/features/movie_flow/genre/genre_entity.dart';
import 'package:my_movie/src/features/movie_flow/movie_repository.dart';
import 'package:my_movie/src/features/movie_flow/result/movie_entity.dart';

class StubMovieRepository implements MovieRepository {
  @override
  Future<List<GenreEntity>> getMovieGenres() async =>
      Future.value([const GenreEntity(id: 1, name: 'Animation')]);

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
          double rating, String date, String genreIds) =>
      Future.value(
        [
          const MovieEntity(
            title: 'Naruto',
            overview: 'A little kid who dreamed become Hokage',
            voteAverage: 10,
            genreIds: [1],
            releaseDate: '2002-02-02',
          )
        ],
      );
}
