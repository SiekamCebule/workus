import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String labelForDuration(BuildContext context, Duration duration,
    {bool excludeSeconds = false}) {
  int hours = duration.inHours;
  int minutes = duration.inMinutes.remainder(60);
  int seconds = duration.inSeconds.remainder(60);

  List<String> parts = [];

  if (hours > 0) {
    parts.add(AppLocalizations.of(context)!.durationHours(hours));
    if (minutes > 0 || seconds > 0) {
      parts.add(AppLocalizations.of(context)!.durationMinutes(atLeastTwoDigit(minutes)));
    }
    if (!excludeSeconds && seconds > 0) {
      parts.add(AppLocalizations.of(context)!.durationSeconds(atLeastTwoDigit(seconds)));
    }
  } else if (minutes > 0) {
    parts.add(AppLocalizations.of(context)!.durationMinutes(minutes));
    if (!excludeSeconds && seconds > 0) {
      parts.add(AppLocalizations.of(context)!.durationSeconds(atLeastTwoDigit(seconds)));
    }
  } else if (seconds > 0 && !excludeSeconds) {
    parts.add(AppLocalizations.of(context)!.durationSeconds(seconds));
  } else {
    parts.add(AppLocalizations.of(context)!.durationZeroMinutes);
  }

  return parts.join(' ');
}

String atLeastTwoDigit(int number) {
  return number.toString().padLeft(2, '0');
}
