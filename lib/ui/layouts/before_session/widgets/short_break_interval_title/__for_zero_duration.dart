part of 'short_break_interval_title.dart';

class _ForZeroDuration extends StatelessWidget {
  const _ForZeroDuration();

  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.noShortBreaks,
      style:
          Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
    );
  }
}
