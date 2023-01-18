import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_movie/src/core/constants.dart';

import '../../../theme/palette.dart';
import 'genre.dart';

class ListCard extends StatelessWidget {
  const ListCard({Key? key, required this.genre, required this.onTap})
      : super(key: key);

  final Genre genre;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return UnconstrainedBox(
      child: Material(
        color:
            genre.isSelected ? Palette.red500 : Colors.transparent,
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(kBorderRadius),
          onTap: onTap,
          child: SizedBox(
            width: 140,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                genre.name,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
