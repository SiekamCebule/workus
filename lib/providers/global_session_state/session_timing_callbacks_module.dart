import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/session_flow/session_timing_callbacks_invoker.dart';
import 'package:workus/session_flow/session_timing_callbacks_registrar.dart';

final sessionTimingCallbacksRegistrarProvider = Provider((ref) {
  return SessionTimingCallbacksRegistrar();
});

final sessionTimingCallbacksInvokerProvider = Provider((ref) {
  return SessionTimingCallbacksInvoker(
    registrar: ref.watch(sessionTimingCallbacksRegistrarProvider),
  );
});
