import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Genre extends Equatable {
  final String name;
  final bool isSelected;
  final int id;

  const Genre({required this.name, this.isSelected = false, this.id = 0});

  Genre toggleSelected() => Genre(name: name, id: id, isSelected: !isSelected);

  @override
  List<Object?> get props => [name, id, isSelected];
}
