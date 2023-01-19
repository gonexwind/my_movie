import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie/src/features/movie_flow/movie_flow_state.dart';

import 'genre/genre.dart';

final movieFlowControllerProvider =
    StateNotifierProvider.autoDispose<MovieFlowController, MovieFlowState>(
  (ref) => MovieFlowController(
    MovieFlowState(
      pageController: PageController(),
    ),
  ),
);

class MovieFlowController extends StateNotifier<MovieFlowState> {
  MovieFlowController(MovieFlowState state) : super(state);

  void toggleSelected(Genre genre) {
    state = state.copyWith(genres: [
      for (final old in state.genres)
        if (old == genre) old.toggleSelected() else old
    ]);
  }

  void updateRating(int updated) {
    state = state.copyWith(rating: updated);
  }

  void updateYearsBack(int updated) {
    state = state.copyWith(yearsBack: updated);
  }

  void nextPage() {
    if (state.pageController.page! >= 1) {
      if (!state.genres.any((genre) => genre.isSelected == true)) {
        return;
      }
    }

    state.pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  void previousPage() {
    state.pageController.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}
