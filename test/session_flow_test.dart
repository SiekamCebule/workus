import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/session_flow/session_stats_broadcaster.dart';
import 'package:workus/session_flow/session_status_controller.dart';
import 'package:workus/session_flow/session_timing_callbacks_invoker.dart';
import 'package:workus/session_flow/session_timing_callbacks_registrar.dart';
import 'package:workus/session_flow/session_timing_configuration.dart';
import 'package:workus/session_flow/session_timing_controller.dart';
import 'package:workus/session_flow/user_session_controller.dart';

void main() {
  late SessionTimingConfiguration timingConfiguration;
  late UserSessionController userController;
  late SessionTimingController timingController;
  late SessionStatusController statusController;
  late SessionTimingCallbacksInvoker timingCallbacksInvoker;
  late SessionTimingCallbacksRegistrar timingCallbacksRegistrar;
  late SessionStatsBroadcaster statsBroadcaster;
  late Stopwatch stopwatch;
  late Completer sessionEndCompleter;
  late Completer sessionCancellationCompleter;

  setUp(() {
    stopwatch = Stopwatch();
    sessionEndCompleter = Completer.sync();
    sessionCancellationCompleter = Completer.sync();
    timingCallbacksRegistrar = SessionTimingCallbacksRegistrar();
    timingCallbacksInvoker =
        SessionTimingCallbacksInvoker(registrar: timingCallbacksRegistrar);
    timingController = SessionTimingController(callbacksInvoker: timingCallbacksInvoker);
    statusController = SessionStatusController()
      ..registerOnChange(
        (status) {
          if (status == WorkSessionStatus.afterWork) {
            sessionEndCompleter.complete();
          } else if (status == WorkSessionStatus.notStarted) {
            sessionCancellationCompleter.complete();
          }
        },
      );
    userController = UserSessionController(
        timingController: timingController,
        statusController: statusController,
        callbacksRegistrar: timingCallbacksRegistrar);
    statsBroadcaster = SessionStatsBroadcaster(
      callbacksRegistrar: timingCallbacksRegistrar,
      timingController: timingController,
      statusController: statusController,
    );
  });

  group('session flow', () {
    test('simple_lapse', () async {
      stopwatch.start();
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 6),
        shortBreaksInterval: Duration.zero,
      );

      timingController.start(timingConfiguration: timingConfiguration);
      await sessionEndCompleter.future;
      expect(stopwatch.elapsed.inSeconds, 6);
    });

    test('timer\'s properties', () async {
      stopwatch.start();
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 8),
        shortBreaksInterval: Duration(seconds: 6),
      );

      userController.start(timingConfiguration: timingConfiguration);
      Future.delayed(const Duration(seconds: 5), () {
        expect(timingController.elapsedSessionTime, const Duration(seconds: 5));
        expect(timingController.remainingSessionTime, const Duration(seconds: 3));
        expect(timingController.timeToShortBreak, const Duration(seconds: 2));
        userController.cancel();
      });
      await sessionCancellationCompleter.future;
    });

    test('lapse with pause and resume', () async {
      stopwatch.start();
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 10),
        shortBreaksInterval: Duration.zero,
      );

      userController.start(timingConfiguration: timingConfiguration);
      Future.delayed(const Duration(milliseconds: 3000), () {
        userController.pause();
      });
      Future.delayed(const Duration(milliseconds: 4600), () {
        userController.resume();
      });
      Future.delayed(const Duration(milliseconds: 5900), () {
        userController.pause();
      });
      Future.delayed(const Duration(milliseconds: 7150), () {
        userController.resume();
      });

      await sessionEndCompleter.future;
      expect(stopwatch.elapsed.inSeconds, 13);
    });

    test('lapse with short breaks', () async {
      stopwatch.start();
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 10),
        shortBreaksInterval: Duration(seconds: 5),
      );

      userController.start(timingConfiguration: timingConfiguration);
      statsBroadcaster.sessionShortBreakStarts.listen((_) {
        Future.delayed(const Duration(seconds: 2), () {
          userController.endShortBreak();
        });
      });

      await sessionEndCompleter.future;
      expect(stopwatch.elapsed.inSeconds, 12);
    });

    test('lapse with cancelling', () async {
      stopwatch.start();
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 7),
        shortBreaksInterval: Duration(seconds: 5),
      );
      userController.start(timingConfiguration: timingConfiguration);
      Future.delayed(const Duration(seconds: 4), () {
        userController.cancel();
      });

      await sessionCancellationCompleter.future;
      expect(stopwatch.elapsed.inSeconds, 4);
      expect(statusController.status, WorkSessionStatus.notStarted);
    });

    test('lapse with short breaks, pauses, and resumes', () async {
      stopwatch.start();
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 10),
        shortBreaksInterval: Duration(seconds: 4),
      );
      userController.start(timingConfiguration: timingConfiguration);
      statsBroadcaster.sessionShortBreakStarts.listen((_) {
        Future.delayed(const Duration(seconds: 3), () {
          userController.endShortBreak();
        });
      });

      Future.delayed(const Duration(seconds: 8), () {
        userController.pause();
      });

      Future.delayed(const Duration(milliseconds: 9500), () {
        userController.resume();
      });

      await sessionEndCompleter.future;
      expect(
          stopwatch.elapsed.inMilliseconds > 18500 &&
              stopwatch.elapsedMilliseconds < 18600,
          true);
      expect(statusController.status, WorkSessionStatus.afterWork);
    });
  });

  group('SessionStatsBroadcaster', () {
    test('streaming: remaining time', () async {
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 6),
        shortBreaksInterval: Duration.zero,
      );
      userController.start(timingConfiguration: timingConfiguration);
      final remainingMilliseconds = await statsBroadcaster.remainingTimes
          .map((remaining) => remaining.inMilliseconds)
          .take(6)
          .toList();

      await sessionEndCompleter.future;
      statsBroadcaster.close();
      expect(remainingMilliseconds, [6000, 5000, 4000, 3000, 2000, 1000]);
    });

    test('streaming: elapsed time', () async {
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 6),
        shortBreaksInterval: Duration.zero,
      );
      userController.start(timingConfiguration: timingConfiguration);

      await sessionEndCompleter.future;
      statsBroadcaster.close();
      final elapsedMilliseconds = await statsBroadcaster.elapsedTimes
          .map((elapsed) => elapsed.inMilliseconds)
          .take(6)
          .toList();
      expect(elapsedMilliseconds, [0000, 1000, 2000, 3000, 4000, 5000]);
    });

    test('streaming: work session status', () async {
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 10),
        shortBreaksInterval: Duration(seconds: 6),
      );
      userController.start(timingConfiguration: timingConfiguration);
      userController.pause();
      userController.resume();
      await Future.delayed(const Duration(milliseconds: 7000));
      userController.endShortBreak();
      await Future.delayed(const Duration(milliseconds: 1000));
      userController.cancel();

      await sessionEndCompleter.future;
      statsBroadcaster.close();
      final statuses = await statsBroadcaster.sessionStatuses.take(6).toList();
      expect(
        statuses,
        [
          WorkSessionStatus.notStarted,
          WorkSessionStatus.running,
          WorkSessionStatus.pausedByUser,
          WorkSessionStatus.running,
          WorkSessionStatus.shortBreak,
          WorkSessionStatus.running,
          WorkSessionStatus.notStarted,
        ],
      );
    });

    test('streaming: time to short break', () async {
      timingConfiguration = const SessionTimingConfiguration(
        totalDuration: Duration(seconds: 6),
        shortBreaksInterval: Duration(seconds: 3),
      );
      userController.start(timingConfiguration: timingConfiguration);
      statsBroadcaster.sessionShortBreakStarts.listen((_) {
        userController.endShortBreak();
      });

      await sessionEndCompleter.future;
      statsBroadcaster.close();
      final millisecondsToShortBeak = await statsBroadcaster.timesToShortBreak
          .map((duration) => duration!.inMilliseconds)
          .take(6)
          .toList();
      expect(millisecondsToShortBeak, [3000, 2000, 1000, 0, 2000, 1000]);
    });
  });
}
