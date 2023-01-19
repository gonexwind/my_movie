import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie/src/features/movie_flow/landing/landing_page.dart';

import 'genre/genre_page.dart';
import 'movie_flow_controller.dart';
import 'rating/rating_page.dart';
import 'years_back/years_back.dart';

class MovieFlow extends ConsumerWidget {
  const MovieFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      controller: ref.watch(movieFlowControllerProvider).pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LandingPage(),
        GenrePage(),
        RatingPage(),
        YearsBackPage(),
      ],
    );
  }
}
