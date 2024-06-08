import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/dropdown_choices.dart';

class DefaultSessionTimingConfigurationGuard {
  late WidgetRef _ref;
  late ProviderSubscription _defaultSessionDurationChangesSubscription;
  late ProviderSubscription _defaultShortBreaksIntervalChangesSubscription;

  void run(WidgetRef ref) {
    _ref = ref;
    _runForDefaultSessionDuration();
    _runForShortBreaksInterval();
  }

  void _runForDefaultSessionDuration() {
    _defaultShortBreaksIntervalChangesSubscription = _ref
        .listenManual(defaultShortBreaksIntervalProvider, (prev, shortBreaksInterval) {
      final sessionDuration = _ref.read(defaultSessionDurationProvider);
      if (shortBreaksInterval >= sessionDuration) {
        for (var potential in defaultSessionDurationChoices) {
          if (potential > shortBreaksInterval) {
            _ref.read(defaultSessionDurationProvider.notifier).state = potential;
            return;
          }
        }
      }
    });
  }

  void _runForShortBreaksInterval() {
    _ref.listenManual(defaultSessionDurationProvider, (prev, sessionDuration) {
      final shortBreaksInterval = _ref.read(defaultShortBreaksIntervalProvider);
      if (sessionDuration <= shortBreaksInterval) {
        for (var potential in defaultShortBreaksIntervalChoices.reversed) {
          if (potential < sessionDuration) {
            _ref.read(defaultShortBreaksIntervalProvider.notifier).state = potential;
            return;
          }
        }
      }
    });
  }

  void stop() {
    _defaultShortBreaksIntervalChangesSubscription.close();
    _defaultSessionDurationChangesSubscription.close();
  }
}
