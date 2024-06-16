import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/alarming/alarm_player.dart';
import 'package:workus/alarming/alarm_status_controller.dart';
import 'package:workus/generic/unary_callbacks_invoker.dart';
import 'package:workus/generic/unary_callbacks_registrar.dart';
import 'package:workus/models/alarm_status.dart';

final alarmStatusChangeCalblacksRegistrar = Provider(
  (ref) => UnaryCallbacksRegistrar<AlarmStatus>(),
);

final alarmStatusChangeCallbacksInvoker = Provider(
  (ref) => UnaryCallbacksInvoker<AlarmStatus>(
    registrar: ref.watch(alarmStatusChangeCalblacksRegistrar),
  ),
);

final alarmStatusController = Provider(
  (ref) => AlarmStatusController(
    callbacksInvoker: ref.watch(alarmStatusChangeCallbacksInvoker),
  ),
);

final alarmPlayerProvider = Provider(
  (ref) => AlarmPlayer(
    statusController: ref.watch(alarmStatusController),
  ),
);
