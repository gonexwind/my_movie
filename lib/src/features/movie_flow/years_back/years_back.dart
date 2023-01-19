import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';

class YearsBackPage extends StatefulWidget {
  const YearsBackPage({
    Key? key,
    required this.nextPage,
    required this.previousPage,
  }) : super(key: key);

  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  State<YearsBackPage> createState() => _YearsBackPageState();
}

class _YearsBackPageState extends State<YearsBackPage> {
  double yearsBack = 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(leading: BackButton(onPressed: widget.previousPage)),
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
                  yearsBack.ceil().toString(),
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
              onChanged: (value) => setState(() => yearsBack = value),
              value: yearsBack,
              min: 0,
              max: 70,
              divisions: 70,
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: widget.nextPage,
              text: l10n.amazing,
            ),
            const SizedBox(height: kMediumSpacing),
          ],
        ),
      ),
    );
  }
}
