import 'package:flutter/material.dart';
import 'package:my_movie/src/features/movie_flow/landing/landing_page.dart';

import 'genre/genre_page.dart';

class MovieFlow extends StatefulWidget {
  const MovieFlow({Key? key}) : super(key: key);

  @override
  State<MovieFlow> createState() => _MovieFlowState();
}

class _MovieFlowState extends State<MovieFlow> {
  final pageController = PageController();

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(microseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(microseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        LandingPage(nextPage: nextPage, previousPage: previousPage),
        GenrePage(nextPage: nextPage, previousPage: previousPage),

        Scaffold(body: Container(color: Colors.lightBlueAccent)),
        Scaffold(body: Container(color: Colors.amberAccent)),
        Scaffold(body: Container(color: Colors.greenAccent)),
      ],
    );
  }
}
