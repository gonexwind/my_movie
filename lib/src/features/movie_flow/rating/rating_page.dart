import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/constants.dart';
import '../../../core/widgets/primary_button.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({
    Key? key,
    required this.nextPage,
    required this.previousPage,
  }) : super(key: key);

  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  double rating = 5;

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
              l10n.selectMinimumRating,
              style: theme.textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rating.ceil().toString(),
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
              onChanged: (value) => setState(() => rating = value),
              value: rating,
              min: 1,
              max: 10,
              divisions: 10,
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: widget.nextPage,
              text: l10n.yesPlease,
            ),
            const SizedBox(height: kMediumSpacing),
          ],
        ),
      ),
    );
  }
}
