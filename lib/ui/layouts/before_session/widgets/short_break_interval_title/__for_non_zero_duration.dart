part of 'short_break_interval_title.dart';

class _ForNonZeroDuration extends StatelessWidget {
  const _ForNonZeroDuration({
    required this.duration,
  });

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '${AppLocalizations.of(context)!.shortBreakEvery} ',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: labelForDuration(context, duration, excludeSeconds: true),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
