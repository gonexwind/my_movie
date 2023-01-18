import 'package:flutter/material.dart';

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
      children: [
        Scaffold(body: Container(color: Colors.lightBlueAccent)),
        Scaffold(body: Container(color: Colors.amberAccent)),
        Scaffold(body: Container(color: Colors.greenAccent)),
      ],
    );
  }
}
