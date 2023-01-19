import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie/src/core/constants.dart';
import 'package:my_movie/src/features/movie_flow/result/movie.dart';

import '../../../core/widgets/primary_button.dart';
import '../landing/landing_page.dart';
import '../movie_flow_controller.dart';

class ResultPage extends ConsumerWidget {
  const ResultPage({Key? key}) : super(key: key);

  static route({bool fullscreenDialog = true}) =>
      MaterialPageRoute(builder: (context) => const ResultPage());

  final double movieHeight = 150;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(movieFlowControllerProvider).movie.when(
          data: (movie) => Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          CoverImage(movie: movie),
                          Positioned(
                            width: MediaQuery.of(context).size.width,
                            bottom: -(movieHeight / 2),
                            child: MovieImageDetails(
                              movie: movie,
                              movieHeight: movieHeight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: movieHeight / 2),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          movie.overview,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ],
                  ),
                ),
                PrimaryButton(
                  onPressed: () => Navigator.of(context).pop(),
                  text: AppLocalizations.of(context)!.findAnotherMovie,
                ),
                const SizedBox(height: kMediumSpacing),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) =>
              Text(AppLocalizations.of(context)!.somethingWhenWrong),
        );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 298),
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Colors.transparent,
            ],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.network(
          movie.backdropPath ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, e, s) => const SizedBox(),
        ),
      ),
    );
  }
}

class MovieImageDetails extends StatelessWidget {
  const MovieImageDetails(
      {Key? key, required this.movieHeight, required this.movie})
      : super(key: key);

  final double movieHeight;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            height: movieHeight,
            child: Image.network(
              movie.posterPath ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, e, s) => const SizedBox(),
            ),
          ),
          const SizedBox(width: kMediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: theme.textTheme.headline6,
                ),
                Text(
                  movie.genresCommaSeparated,
                  style: theme.textTheme.bodyText2,
                ),
                Text(
                  movie.releaseDate,
                  style: theme.textTheme.bodyText2,
                ),
                Row(
                  children: [
                    Text(
                      movie.voteAverage.toString(),
                      style: theme.textTheme.bodyText2?.copyWith(
                        color:
                            theme.textTheme.bodyText2?.color?.withOpacity(0.62),
                      ),
                    ),
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
