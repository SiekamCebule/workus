part of 'mini_break_interval_title.dart';

class _ForNonZeroDuration extends StatelessWidget {
  const _ForNonZeroDuration({
    super.key,
    required this.duration,
  });

  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Krótka przerwa co ',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: labelForDuration(duration),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
