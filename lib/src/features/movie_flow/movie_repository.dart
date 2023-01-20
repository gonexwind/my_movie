import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie/src/core/environment_variables.dart';
import 'package:my_movie/src/features/movie_flow/genre/genre_entity.dart';

import '../../app.dart';
import '../../core/failure.dart';
import 'result/movie_entity.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TMDBMovieRepository(dio: dio);
});

abstract class MovieRepository {
  Future<List<GenreEntity>> getMovieGenres();

  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds);
}

class TMDBMovieRepository implements MovieRepository {
  final Dio dio;

  TMDBMovieRepository({required this.dio});

  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    try {
      final response = await dio.get(
        'genre/movie/list',
        queryParameters: {
          'api_key': api,
          'language': 'en-US',
        },
      );
      final result = List<Map<String, dynamic>>.from(response.data['genres']);
      final genres = result.map((e) => GenreEntity.fromMap(e)).toList();
      return genres;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message: 'No internet connection',
          exception: e,
        );
      }
      throw Failure(
        message: e.response?.statusMessage ?? 'something went wrong',
        code: e.response?.statusCode,
      );
    }
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds) async {
    try {
      final response = await dio.get(
        'discover/movie',
        queryParameters: {
          'api_key': api,
          'language': 'en-US',
          'sort_by': 'popularity.desc',
          'include_adult': true,
          'vote_average.gte': rating,
          'page': 1,
          'release_dae.gte': date,
          'with_genres': genreIds,
        },
      );
      final result = List<Map<String, dynamic>>.from(response.data['results']);
      final movies = result.map((e) => MovieEntity.fromMap(e)).toList();
      return movies;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message: 'No internet connection',
          exception: e,
        );
      }
      throw Failure(
        message: e.response?.statusMessage ?? 'something went wrong',
        code: e.response?.statusCode,
      );
    }
  }
}
