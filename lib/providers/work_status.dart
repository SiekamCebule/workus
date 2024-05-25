import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WorkStatus {
  nonStarted,
  running,
  miniBreak,
  paused,
  ended;
}

final workStatusProvider = StateProvider<WorkStatus>(
  (ref) => WorkStatus.nonStarted,
);
