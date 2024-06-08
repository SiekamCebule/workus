import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

const navbarDestinations = [
  NavigationDestination(
    icon: Icon(Symbols.checklist),
    label: 'Zadania',
  ),
  NavigationDestination(
    icon: Icon(Symbols.timelapse),
    label: 'Praca',
  ),
  NavigationDestination(
    icon: Icon(Symbols.settings),
    label: 'Ustawienia',
  ),
];

const navigationRailDestinations = [
  NavigationRailDestination(
    icon: Icon(Symbols.checklist),
    label: Text('Zadania'),
  ),
  NavigationRailDestination(
    icon: Icon(Symbols.timelapse),
    label: Text('Praca'),
  ),
  NavigationRailDestination(
    icon: Icon(Symbols.settings),
    label: Text('Ustawienia'),
  ),
];
