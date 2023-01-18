import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_movie/src/core/constants.dart';
import 'package:my_movie/src/core/widgets/primary_button.dart';
import 'package:my_movie/src/features/movie_flow/genre/list_card.dart';

import 'genre.dart';

class GenrePage extends StatefulWidget {
  const GenrePage({
    Key? key,
    required this.nextPage,
    required this.previousPage,
  }) : super(key: key);

  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  State<GenrePage> createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  List<Genre> genres = const [
    Genre(name: 'Action'),
    Genre(name: 'Comedy'),
    Genre(name: 'Horror'),
    Genre(name: 'Drama'),
    Genre(name: 'Family'),
  ];

  void toggleSelected(Genre genre) {
    List<Genre> updatedGenres = [
      for (final oldGenre in genres)
        if (oldGenre == genre) oldGenre.toggleSelected() else oldGenre
    ];
    setState(() => genres = updatedGenres);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: widget.previousPage),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              l10n.letsStartWithAGenre,
              style: theme.textTheme.headline5,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return ListCard(
                    genre: genre,
                    onTap: () => toggleSelected(genre),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: kListItemSpacing),
                itemCount: genres.length,
                padding: const EdgeInsets.symmetric(vertical: kListItemSpacing),
              ),
            ),
            PrimaryButton(
              onPressed: widget.nextPage,
              text: l10n.continueText,
            ),
            const SizedBox(height: kMediumSpacing),
          ],
        ),
      ),
    );
  }
}
