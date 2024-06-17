import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/app_state/configuration/work_configuration.dart';
import 'package:workus/app_state/global_session_state/alarm_playing_module.dart';
import 'package:workus/app_state/global_session_state/session_controlling_module.dart';
import 'package:workus/session_flow/session_timing_configuration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExtendSessionSimpleDialog extends ConsumerStatefulWidget {
  const ExtendSessionSimpleDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ExtendSessionSimpleDialogState();
  }
}

class _ExtendSessionSimpleDialogState extends ConsumerState<ExtendSessionSimpleDialog> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(AppLocalizations.of(context)!.extendSessionBy),
      children: [
        SimpleDialogOption(
          onPressed: () {
            ref.watch(alarmPlayerProvider).stop();
            _extendSession(const Duration(minutes: 5));
            _closeDialog();
          },
          child: Text('5 ${AppLocalizations.of(context)!.minutes(5)}'),
        ),
        SimpleDialogOption(
          onPressed: () {
            ref.watch(alarmPlayerProvider).stop();
            _extendSession(const Duration(minutes: 15));
            _closeDialog();
          },
          child: Text('15 ${AppLocalizations.of(context)!.minutes(15)}'),
        ),
        SimpleDialogOption(
          onPressed: () {
            ref.watch(alarmPlayerProvider).stop();
            _extendSession(const Duration(minutes: 30));
            _closeDialog();
          },
          child: Text('30 ${AppLocalizations.of(context)!.minutes(30)}'),
        ),
      ],
    );
  }

  void _extendSession(Duration sessionDuration) {
    final controller = ref.read(userSessionControllerProvider);
    controller.start(
      timingConfiguration: SessionTimingConfiguration(
        sessionDuration: sessionDuration,
        shortBreaksInterval: null,
      ),
    );
    ref.read(smallBreaksAreEnabledProvider.notifier).state = false;
  }

  void _closeDialog() {
    Navigator.of(context).pop();
  }
}

Future<void> showExtendSessionSimpleDialog(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return const ExtendSessionSimpleDialog();
    },
  );
}
