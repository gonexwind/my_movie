import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie/src/core/constants.dart';
import 'package:my_movie/src/features/movie_flow/result/movie.dart';

import '../../../core/failure.dart';
import '../../../core/widgets/failure_screen.dart';
import '../../../core/widgets/network_fading_image.dart';
import '../../../core/widgets/primary_button.dart';
import '../movie_flow_controller.dart';

class ResultPageAnimator extends StatefulWidget {
  const ResultPageAnimator({Key? key}) : super(key: key);

  @override
  State<ResultPageAnimator> createState() => _ResultPageAnimatorState();
}

class _ResultPageAnimatorState extends State<ResultPageAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      ResultPage(animationController: _controller);
}

class ResultPage extends ConsumerWidget {
  ResultPage({Key? key, required this.animationController})
      : titleOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0, 0.3),
          ),
        ),
        genreOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.3, 0.4),
          ),
        ),
        ratingOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.4, 0.6),
          ),
        ),
        releaseDateOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.6, 0.7),
          ),
        ),
        descriptionOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.7, 0.8),
          ),
        ),
        buttonOpacity = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.8, 1),
          ),
        ),
        super(key: key);

  static route({bool fullscreenDialog = true}) => MaterialPageRoute(
        builder: (context) => const ResultPageAnimator(),
        fullscreenDialog: fullscreenDialog,
      );

  final AnimationController animationController;
  final Animation<double> titleOpacity;
  final Animation<double> genreOpacity;
  final Animation<double> ratingOpacity;
  final Animation<double> releaseDateOpacity;
  final Animation<double> descriptionOpacity;
  final Animation<double> buttonOpacity;
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
                              titleOpacity: titleOpacity,
                              genreOpacity: genreOpacity,
                              ratingOpacity: ratingOpacity,
                              releaseDateOpacity: releaseDateOpacity,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: movieHeight / 2),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: FadeTransition(
                          opacity: descriptionOpacity,
                          child: Text(
                            movie.overview,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FadeTransition(
                  opacity: buttonOpacity,
                  child: PrimaryButton(
                    onPressed: () => Navigator.of(context).pop(),
                    text: AppLocalizations.of(context)!.findAnotherMovie,
                  ),
                ),
                const SizedBox(height: kMediumSpacing),
              ],
            ),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, s) {
            if (e is Failure) {
              return FailureScreen(message: e.message);
            }
            return FailureScreen(
                message: AppLocalizations.of(context)!.somethingWhenWrong);
          },
        );
  }
}

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
    required this.movie,
  }) : super(key: key);

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
        child: NetworkFadingImage(path: movie.backdropPath ?? ''),
      ),
    );
  }
}

class MovieImageDetails extends StatelessWidget {
  const MovieImageDetails(
      {Key? key,
      required this.movieHeight,
      required this.movie,
      required this.titleOpacity,
      required this.genreOpacity,
      required this.ratingOpacity,
      required this.releaseDateOpacity})
      : super(key: key);

  final double movieHeight;
  final Movie movie;
  final Animation<double> titleOpacity;
  final Animation<double> genreOpacity;
  final Animation<double> ratingOpacity;
  final Animation<double> releaseDateOpacity;

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
            child: NetworkFadingImage(path: movie.posterPath ?? ''),
          ),
          const SizedBox(width: kMediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeTransition(
                  opacity: titleOpacity,
                  child: Text(
                    movie.title,
                    style: theme.textTheme.headline6,
                  ),
                ),
                FadeTransition(
                  opacity: genreOpacity,
                  child: Text(
                    movie.genresCommaSeparated,
                    style: theme.textTheme.bodyText2,
                  ),
                ),
                FadeTransition(
                  opacity: releaseDateOpacity,
                  child: Text(
                    movie.releaseDate.substring(0, 4),
                    style: theme.textTheme.bodyText2,
                  ),
                ),
                FadeTransition(
                  opacity: ratingOpacity,
                  child: Row(
                    children: [
                      Text(
                        movie.voteAverage.toString(),
                        style: theme.textTheme.bodyText2?.copyWith(
                          color: theme.textTheme.bodyText2?.color
                              ?.withOpacity(0.62),
                        ),
                      ),
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
