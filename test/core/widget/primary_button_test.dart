import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_movie/src/core/widgets/primary_button.dart';

void main() {
  testWidgets('Should find progress indicator When loading is true',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: PrimaryButton(
        onPressed: () {},
        text: '',
        isLoading: true,
      ),
    ));

    final loadingIndicationFinder = find.byType(CircularProgressIndicator);
    expect(loadingIndicationFinder, findsOneWidget);
  });

  testWidgets('Should find no progress indicator When loading is false',
      (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: PrimaryButton(
        onPressed: () {},
        text: 'test',
        isLoading: false,
      ),
    ));

    final loadingIndicationFinder = find.byType(CircularProgressIndicator);
    expect(loadingIndicationFinder, findsNothing);
  });
}
