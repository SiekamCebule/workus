import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Some default duration
final sessionDurationProvider = StateProvider<Duration>(
  (ref) => const Duration(minutes: 30),
);

// TODO: Some default interval
final smallBreakIntervalProvider = StateProvider<Duration>(
  (ref) => const Duration(minutes: 15),
);
