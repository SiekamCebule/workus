import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:workus/models/work_session_status.dart';
import 'package:workus/work_flow/work_flow_controller.dart';
import 'package:workus/work_flow/work_flow_controller_messenger.dart';

void main() {
  late WorkFlowController flowController;
  late WorkFlowControllerMessenger flowControllerMessenger;
  late Completer<void> sessionEndCompleter;
  late Completer<void> sessionCancellationCompleter;
  setUp(() {
    flowController = WorkFlowController.forTesting();
    flowControllerMessenger = WorkFlowControllerMessenger.forTesting(flowController);
    sessionEndCompleter = Completer.sync();
    sessionCancellationCompleter = Completer.sync();
    flowController.registerOnStatusChange((status) {
      if (status == WorkSessionStatus.ended) {
        sessionEndCompleter.complete();
      } else if (status == WorkSessionStatus.cancelled) {
        sessionCancellationCompleter.complete();
      }
    });
  });

  tearDown(() {
    flowControllerMessenger.dispose();
  });

  test('streaming: remaining time', () async {
    final remainingMilliseconds = <int>[];
    flowController.startSession(
      sessionDuration: const Duration(seconds: 6),
      smallBreakInterval: Duration.zero,
    );
    flowControllerMessenger.remainingSessionTimeStream.listen((remaining) {
      remainingMilliseconds.add(remaining.inMilliseconds);
    });

    await sessionEndCompleter.future;
    expect(remainingMilliseconds, [6000, 5000, 4000, 3000, 2000, 1000]);
  });

  test('streaming: elapsed time', () async {
    final millisecondsElapsed = <int>[];
    flowController.startSession(
      sessionDuration: const Duration(seconds: 6),
      smallBreakInterval: Duration.zero,
    );
    flowControllerMessenger.elapsedSessionTimeStream.listen((elapsed) {
      millisecondsElapsed.add(elapsed.inMilliseconds);
    });

    await sessionEndCompleter.future;
    expect(millisecondsElapsed, [0000, 1000, 2000, 3000, 4000, 5000]);
  });

  test('streaming: work session status', () async {
    final fromStream = <WorkSessionStatus>[WorkSessionStatus.nonStarted];
    flowController.startSession(
      sessionDuration: const Duration(seconds: 10),
      smallBreakInterval: const Duration(seconds: 6),
    );
    flowControllerMessenger.workSessionStatusStream.listen((status) {
      fromStream.add(status);
    });

    flowController.pauseSession();
    flowController.resumeSession();
    await Future.delayed(const Duration(milliseconds: 7000));
    flowController.endSmallBreak();
    await Future.delayed(const Duration(milliseconds: 1000));
    flowController.cancelSession();

    await sessionCancellationCompleter.future;
    expect(
      fromStream,
      [
        WorkSessionStatus.nonStarted,
        WorkSessionStatus.running,
        WorkSessionStatus.pausedByUser,
        WorkSessionStatus.running,
        WorkSessionStatus.miniBreak,
        WorkSessionStatus.running,
        WorkSessionStatus.cancelled,
      ],
    );
  });

  test('streaming: time to small break', () async {
    final millisecondsToSmallBreak = <int>[];
    flowController.startSession(
      sessionDuration: const Duration(seconds: 6),
      smallBreakInterval: const Duration(seconds: 3),
    );
    flowController.registerOnStatusChange((status) {
      if (status case WorkSessionStatus.miniBreak) {
        flowController.endSmallBreak();
      }
    });
    flowControllerMessenger.timeToSmallBreakStream.listen((toSmallBreak) {
      millisecondsToSmallBreak.add(toSmallBreak!.inMilliseconds);
    });

    await sessionEndCompleter.future;
    expect(millisecondsToSmallBreak, [3000, 2000, 1000, 0, 2000, 1000]);
  });
}
/*

 print(
          'elapsed: ${flowController.elapsedSessionTime}, time to small break: ${flowController.timeToSmallBreak}');

  or


   print(
          'elapsed: ${flowController.elapsedSessionTime}, time to small break: ${flowController.timeToSmallBreak} (in milliseconds: ${flowController.timeToSmallBreak!.inMilliseconds})');

*/
// 