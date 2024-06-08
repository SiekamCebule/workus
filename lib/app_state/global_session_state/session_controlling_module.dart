import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/global_session_state/session_timing_callbacks_module.dart';
import 'package:workus/session_flow/session_status_controller.dart';

import 'package:workus/session_flow/session_timing_controller.dart';
import 'package:workus/session_flow/user_session_controller.dart';

final sessionTimingControllerProvider = Provider((ref) {
  return SessionTimingController(
    callbacksInvoker: ref.watch(sessionTimingCallbacksInvokerProvider),
  );
});

final sessionStatusControllerProvider = Provider((ref) {
  return SessionStatusController();
});

final userSessionControllerProvider = Provider((ref) {
  return UserSessionController(
    timingController: ref.watch(sessionTimingControllerProvider),
    statusController: ref.watch(sessionStatusControllerProvider),
    callbacksRegistrar: ref.watch(sessionTimingCallbacksRegistrarProvider),
  );
});
