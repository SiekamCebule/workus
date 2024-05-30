import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/work_flow/work_flow_controller.dart';
import 'package:workus/work_flow/work_flow_controller_messenger.dart';

void main() {
  late WorkFlowController flowController;
  late WorkFlowControllerMessenger flowControllerMessenger;
  late Stopwatch stopwatch;
  late Completer sessionEndCompleter;
  late Completer sessionCancellationCompleter;
  late int ticks;
  setUp(() {
    flowController = WorkFlowController.forTesting();
    flowControllerMessenger = WorkFlowControllerMessenger.forTesting(flowController);
    stopwatch = Stopwatch();
    sessionEndCompleter = Completer<void>.sync();
    sessionCancellationCompleter = Completer<void>.sync();
    ticks = 0;
    flowController.registerOnTick(() => ticks++);
    flowController.registerOnStatusChange((status) {
      if (status == WorkSessionStatus.ended) {
        if (!sessionEndCompleter.isCompleted) {
          sessionEndCompleter.complete();
        }
      } else if (status == WorkSessionStatus.cancelled) {
        if (!sessionCancellationCompleter.isCompleted) {
          sessionCancellationCompleter.complete();
        }
      }
    });
  });

  tearDown(() {
    flowController.dispose();
    stopwatch.stop();
    stopwatch.reset();
  });

  // 0:00:13.157624
  // 0:00:14.152406

  test('simple lapse', () async {
    stopwatch.start();
    flowController.startSession(
      sessionDuration: const Duration(seconds: 6),
      smallBreakInterval: Duration.zero,
    );

    await sessionEndCompleter.future;
    expect(stopwatch.elapsed.inSeconds, 6);
  });

  test('timer\'s properties', () async {
    flowController.startSession(
      sessionDuration: const Duration(seconds: 8),
      smallBreakInterval: const Duration(seconds: 7),
    );
    Future.delayed(const Duration(milliseconds: 5010), () {
      expect(flowController.elapsedSessionTime, const Duration(seconds: 5));
      expect(flowController.remainingSessionTime, const Duration(seconds: 3));
      expect(flowController.timeToSmallBreak, const Duration(seconds: 2));
      flowController.cancelSession();
    });

    await sessionCancellationCompleter.future;
  });

  test('lapse with pause and resume', () async {
    stopwatch.start();

    flowController.startSession(
        sessionDuration: const Duration(seconds: 10), smallBreakInterval: Duration.zero);

    await Future.delayed(const Duration(milliseconds: 3000));
    flowController.pauseSession();
    await Future.delayed(const Duration(milliseconds: 1600));
    flowController.resumeSession();
    await Future.delayed(const Duration(milliseconds: 2300));
    flowController.pauseSession();
    await Future.delayed(const Duration(milliseconds: 1250));
    flowController.resumeSession();

    await sessionEndCompleter.future;
    expect(ticks, 11);

    expect(stopwatch.elapsed.inSeconds, 13);
  });

  test('lapse with small breaks', () async {
    stopwatch.start();
    flowController.startSession(
      sessionDuration: const Duration(seconds: 10),
      smallBreakInterval: const Duration(seconds: 5),
    );

    final smallBreaks = flowControllerMessenger.workSessionStatusStream.where(
      (status) => status == WorkSessionStatus.miniBreak,
    );
    smallBreaks.listen((_) {
      Future.delayed(const Duration(seconds: 2), () {
        flowController.endSmallBreak();
      });
    });

    await sessionEndCompleter.future;
    expect(ticks, 11);
    expect(stopwatch.elapsed.inSeconds, 12);
  });

  test('lapse with cancelling', () async {
    stopwatch.start();
    flowController.startSession(
      sessionDuration: const Duration(seconds: 7),
      smallBreakInterval: const Duration(seconds: 5),
    );
    Future.delayed(const Duration(milliseconds: 4001), () {
      flowController.cancelSession();
    });

    await sessionCancellationCompleter.future;
    expect(ticks, 5);
    expect(stopwatch.elapsed.inSeconds, 4);
    expect(flowController.status, WorkSessionStatus.cancelled);
  });

  test('lapse with small breaks, pauses, and resumes', () async {
    stopwatch.start();
    flowController.startSession(
      sessionDuration: const Duration(seconds: 10),
      smallBreakInterval: const Duration(seconds: 4),
    );

    flowControllerMessenger.workSessionStatusStream
        .where(
      (status) => status == WorkSessionStatus.miniBreak,
    )
        .listen((_) {
      Future.delayed(const Duration(seconds: 3), () {
        flowController.endSmallBreak();
      });
    });

    Future.delayed(const Duration(seconds: 8), () {
      flowController.pauseSession();
    });
    Future.delayed(const Duration(milliseconds: 9500), () {
      flowController.resumeSession();
    });

    await sessionEndCompleter.future;
    expect(ticks, 11);
    expect(
        stopwatch.elapsed.inMilliseconds > 18500 && stopwatch.elapsedMilliseconds < 18600,
        true);
    expect(flowController.status, WorkSessionStatus.ended);
  });
}
