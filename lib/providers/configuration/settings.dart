import 'package:flutter_riverpod/flutter_riverpod.dart';

final shouldShowQuotesProvider = StateProvider<bool>(
  (ref) => true,
);

final shouldShowIncompletedTasksWarnings = StateProvider<bool>(
  (ref) => true,
);

final defaultSessionDurationProvider = StateProvider<Duration>(
  (ref) => const Duration(hours: 1),
);

final defaultShortBreaksIntervalProvider = StateProvider<Duration>(
  (ref) => const Duration(minutes: 30),
);

final shortBreakRemindDelayProvider = Provider<Duration>(
  (ref) => const Duration(seconds: 12),
);
