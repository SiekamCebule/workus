import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WorkStatus {
  running,
  miniBreak,
  pausedByUser,
  ended;
}

final workStatusProvider = StateProvider<WorkStatus?>(
  (ref) => null,
);
