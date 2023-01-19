import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:my_movie/src/features/movie_flow/genre/genre_entity.dart';

class Genre extends Equatable {
  final String name;
  final bool isSelected;
  final int id;

  const Genre({required this.name, this.isSelected = false, this.id = 0});

  factory Genre.fromEntity(GenreEntity entity) {
    return Genre(name: entity.name, id: entity.id, isSelected: false);
  }

  Genre toggleSelected() => Genre(name: name, id: id, isSelected: !isSelected);

  @override
  List<Object?> get props => [name, id, isSelected];
}
