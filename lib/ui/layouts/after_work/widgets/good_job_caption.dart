import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoodJobCaption extends StatelessWidget {
  const GoodJobCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.goodJob,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
