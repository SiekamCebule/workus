import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<NavigationDestination> navbarDestinations(BuildContext context) {
  return [
    NavigationDestination(
      icon: const Icon(Symbols.checklist),
      label: AppLocalizations.of(context)!.tasks,
    ),
    NavigationDestination(
      icon: const Icon(Symbols.timelapse),
      label: AppLocalizations.of(context)!.work,
    ),
    NavigationDestination(
      icon: const Icon(Symbols.settings),
      label: AppLocalizations.of(context)!.settings,
    )
  ];
}

List<NavigationRailDestination> navigationRailDestinations(BuildContext context) {
  return [
    NavigationRailDestination(
      icon: const Icon(Symbols.checklist),
      label: Text(AppLocalizations.of(context)!.tasks),
    ),
    NavigationRailDestination(
      icon: const Icon(Symbols.timelapse),
      label: Text(AppLocalizations.of(context)!.work),
    ),
    NavigationRailDestination(
      icon: const Icon(Symbols.settings),
      label: Text(AppLocalizations.of(context)!.settings),
    )
  ];
}
