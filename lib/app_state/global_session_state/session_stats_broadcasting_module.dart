import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/app_state/global_session_state/session_timing_callbacks_module.dart';
import 'package:workus/session_flow/session_stats_broadcaster.dart';

final sessionStatsBroadcasterProvider = Provider((ref) {
  return SessionStatsBroadcaster(
    timingController: ref.watch(sessionTimingControllerProvider),
    statusController: ref.watch(sessionStatusControllerProvider),
    callbacksRegistrar: ref.watch(sessionTimingCallbacksRegistrarProvider),
  );
});
