import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Some default duration
final sessionDurationProvider = StateProvider<Duration>(
  (ref) => Duration.zero,
);

// TODO: Some default interval
final miniBreakIntervalProvider = StateProvider<Duration>(
  (ref) => Duration.zero,
);
