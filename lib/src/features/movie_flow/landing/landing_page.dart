import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    Key? key,
    required this.nextPage,
    required this.previousPage,
  }) : super(key: key);

  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
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
              onPressed: nextPage,
              text: l10n.getStarted,
            ),
            const SizedBox(height: kMediumSpacing),
          ],
        ),
      ),
    );
  }
}
