import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShortBreakMainCaption extends StatelessWidget {
  const ShortBreakMainCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Text(
        AppLocalizations.of(context)!.takeABreak,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
