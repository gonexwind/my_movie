import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_movie/src/core/widgets/failure_screen.dart';

void main() {
  testWidgets('Should return message When rendering failurescreen',
      (tester) async {
    const message = 'no';
    await tester.pumpWidget(
      const MaterialApp(home: FailureScreen(message: message)),
    );
    expect(find.text(message), findsOneWidget);
  });
}
