import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie/src/core/constants.dart';
import 'package:my_movie/src/core/widgets/primary_button.dart';
import 'package:my_movie/src/features/movie_flow/genre/list_card.dart';

import '../movie_flow_controller.dart';

class GenrePage extends ConsumerWidget {
  const GenrePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final state = ref.read(movieFlowControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: state.previousPage),
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
                  final genre =
                      ref.watch(movieFlowControllerProvider).genres[index];
                  return ListCard(
                    genre: genre,
                    onTap: () => state.toggleSelected(genre),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: kListItemSpacing),
                itemCount: ref.watch(movieFlowControllerProvider).genres.length,
                padding: const EdgeInsets.symmetric(vertical: kListItemSpacing),
              ),
            ),
            PrimaryButton(
              onPressed: state.nextPage,
              text: l10n.continueText,
            ),
            const SizedBox(height: kMediumSpacing),
          ],
        ),
      ),
    );
  }
}
