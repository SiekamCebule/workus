import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:workus/models/quote.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuoteWidget extends ConsumerWidget {
  const QuoteWidget({
    super.key,
    required this.quote,
  });

  final Quote quote;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IntrinsicWidth(
          child: Text(
            quote.content,
            style: contentTextStyle(context),
          ),
        ),
        const Gap(4),
        IntrinsicWidth(
          child: Text(
            '~ ${quote.author ?? AppLocalizations.of(context)!.authorUnknown}',
            style: authorTextStyle(context),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  TextStyle contentTextStyle(BuildContext context) {
    return GoogleFonts.glassAntiqua(
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w400));
  }

  TextStyle authorTextStyle(BuildContext context) {
    return GoogleFonts.glassAntiqua(
        textStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.w600));
  }
}
