import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';
import '../movie_flow_controller.dart';

class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final state = ref.read(movieFlowControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              l10n.letsFindAMovie,
              style: theme.textTheme.headline5,
            ),
            const Spacer(),
            Image.asset('assets/images/landing_hero.png'),
            const Spacer(),
            PrimaryButton(
              onPressed: state.nextPage,
              text: l10n.getStarted,
            ),
            const SizedBox(height: kMediumSpacing),
          ],
        ),
      ),
    );
  }
}
