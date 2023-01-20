import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:my_movie/src/app.dart';
import 'package:my_movie/src/core/widgets/primary_button.dart';
import 'package:my_movie/src/features/movie_flow/movie_repository.dart';

import 'stubs/stub_movie_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'test basic flow and see the fake generated movie in the end',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            movieRepositoryProvider.overrideWithValue(StubMovieRepository())
          ],
          child: const MyApp(),
        ),
      );

      await tester.tap(find.byType(PrimaryButton));

      await tester.pumpAndSettle();
      await tester.tap(find.text('Animation'));
      await tester.tap(find.byType(PrimaryButton));

      await tester.pumpAndSettle();
      await tester.tap(find.byType(PrimaryButton));

      await tester.pumpAndSettle();
      await tester.tap(find.byType(PrimaryButton));

      await tester.pumpAndSettle();
      expect(find.text('Naruto'), findsOneWidget);
    },
  );
}
