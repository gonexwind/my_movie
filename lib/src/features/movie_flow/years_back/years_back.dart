import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_movie/src/features/movie_flow/result/result_page.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';
import '../movie_flow_controller.dart';

class YearsBackPage extends ConsumerWidget {
  const YearsBackPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final state = ref.read(movieFlowControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: state.previousPage)),
      body: Center(
        child: Column(
          children: [
            Text(
              l10n.howManyYears,
              style: theme.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ref.watch(movieFlowControllerProvider).yearsBack.toString(),
                  style: theme.textTheme.headline2,
                ),
                Text(
                  l10n.yearsBack,
                  style: theme.textTheme.headline4?.copyWith(
                    color: theme.textTheme.headline4?.color?.withOpacity(0.62),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Slider(
              onChanged: (value) => state.updateYearsBack(value.toInt()),
              value:
                  ref.watch(movieFlowControllerProvider).yearsBack.toDouble(),
              min: 0,
              max: 70,
              divisions: 70,
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: () async {
                await ref
                    .read(movieFlowControllerProvider.notifier)
                    .getRecommendedMovie();
                Navigator.of(context).push(ResultPage.route());
              },
              isLoading:
                  ref.watch(movieFlowControllerProvider).movie is AsyncLoading,
              text: l10n.amazing,
            ),
            const SizedBox(height: kMediumSpacing),
          ],
        ),
      ),
    );
  }
}
