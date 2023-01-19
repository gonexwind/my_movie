import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';
import '../movie_flow_controller.dart';

class RatingPage extends ConsumerWidget {
  const RatingPage({Key? key}) : super(key: key);

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
              l10n.selectMinimumRating,
              style: theme.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ref.watch(movieFlowControllerProvider).rating.toString(),
                  style: theme.textTheme.headline2,
                ),
                const Icon(
                  Icons.star_rounded,
                  color: Colors.amber,
                  size: 62,
                ),
              ],
            ),
            const Spacer(),
            Slider(
              onChanged: (value) => state.updateRating(value.toInt()),
              value: ref.watch(movieFlowControllerProvider).rating.toDouble(),
              min: 1,
              max: 10,
              divisions: 10,
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: state.nextPage,
              text: l10n.yesPlease,
            ),
            const SizedBox(height: kMediumSpacing),
          ],
        ),
      ),
    );
  }
}
