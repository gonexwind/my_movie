import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'genre/genre.dart';
import 'result/movie.dart';

class MovieFlowState extends Equatable {
  final PageController pageController;
  final int rating;
  final int yearsBack;
  final List<Genre> genres;
  final Movie movie;

  const MovieFlowState({
    required this.pageController,
    this.rating = 5,
    this.yearsBack = 10,
    this.genres = genresMock,
    this.movie = movieMock,
  });

  MovieFlowState copyWith({
    PageController? pageController,
    int? rating,
    int? yearsBack,
    List<Genre>? genres,
    Movie? movie,
  }) {
    return MovieFlowState(
      pageController: pageController ?? this.pageController,
      rating: rating ?? this.rating,
      yearsBack: yearsBack ?? this.yearsBack,
      genres: genres ?? this.genres,
      movie: movie ?? this.movie,
    );
  }

  @override
  List<Object?> get props => [pageController, rating, yearsBack, genres, movie];
}

const movieMock = Movie(
  title: 'Wednesday',
  overview:
      'While attending Nevermore Academy, Wednesday Addams attempts to master her emerging psychic ability, thwart a killing spree and solve the mystery that embroiled her parents 25 years ago.',
  voteAverage: 4.8,
  genres: [Genre(name: 'Mystery'), Genre(name: 'Supernatural')],
  releaseDate: '2020-05024',
  backdropPath: '',
  posterPath: '',
);

const genresMock = [
  Genre(name: 'Action'),
  Genre(name: 'Comedy'),
  Genre(name: 'Horror'),
  Genre(name: 'Drama'),
  Genre(name: 'Family'),
];
