import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: add to settings
final shortBreakRemindDelay = Provider<Duration>((ref) => const Duration(seconds: 12));

final defaultNewTaskName = Provider((ref) => 'Nowe zadanie');
