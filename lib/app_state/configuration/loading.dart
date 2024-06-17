import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/generated/libmpv/bindings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workus/app_state/configuration/settings.dart';
import 'package:workus/app_state/constants/app_language.dart';
import 'package:workus/app_state/constants/predefined_alarm_sounds.dart';
import 'package:workus/models/alarm_sound.dart';

class SettingsLoader {
  final BuildContext _context;
  final WidgetRef _ref;
  final SharedPreferences _prefs;

  SettingsLoader(this._ref, this._context, this._prefs);

  static Future<void> load(BuildContext context, WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    if (!context.mounted) return;
    final settingsLoader = SettingsLoader(ref, context, prefs);
    await settingsLoader._loadAllSettings();
  }

  Future<void> _loadAllSettings() async {
    _loadLanguage();
    _loadShowQuotes();
    _loadShowIncompletedTasksWarnings();
    _loadEnableNavigationRailExtendEffect();
    _loadExtendNavigationRail();
    _loadShowNotifications();
    _loadEnableAlarms();
    _loadDefaultSessionDuration();
    _loadDefaultShortBreakInterval();
    _loadShortBreakRemindDelay();
    _loadSessionEndAlarmSound();
    _loadShortBreakAlarmSound();
  }

  void _loadBoolSetting(StateProvider<bool> provider, String key, bool defaultValue) {
    final value = _prefs.getBool(key) ?? defaultValue;
    _ref.read(provider.notifier).state = value;
  }

  void _loadDurationSetting(
      StateProvider<Duration> provider, String key, int defaultMinutes) {
    final value = _prefs.getInt(key) ?? defaultMinutes;
    _ref.read(provider.notifier).state = Duration(minutes: value);
  }

  void _loadStringSetting(
      StateProvider<AlarmSound?> provider, String key, String defaultId) {
    final alarmId = _prefs.getString(key) ?? defaultId;
    _ref.read(provider.notifier).state =
        _ref.read(predefinedAlarmSoundsProvider(_context)).singleWhere(
              (sound) => sound.id == alarmId,
            );
  }

  void _loadLanguage() {
    final systemLang = Platform.localeName.substring(0, 2);
    final langCode = _prefs.getString('language') ?? systemLang;
    _ref.read(languageProvider.notifier).state = AppLanguage.fromCode(langCode);
  }

  void _loadShowQuotes() {
    _loadBoolSetting(shouldShowQuotesProvider, 'should_show_quotes', true);
  }

  void _loadShowIncompletedTasksWarnings() {
    _loadBoolSetting(shouldShowIncompletedTasksWarningsProvider,
        'should_show_incompleted_tasks_warnings', true);
  }

  void _loadEnableNavigationRailExtendEffect() {
    _loadBoolSetting(enableNavigationRailExtendEffectProvider,
        'enable_navigation_rail_extend_effect', false);
  }

  void _loadExtendNavigationRail() {
    _loadBoolSetting(
        shouldExtendNavigationRailProvider, 'should_extend_navigation_rail', false);
  }

  void _loadShowNotifications() {
    _loadBoolSetting(shouldShowNotificationsProvider, 'should_show_notifications', true);
  }

  void _loadEnableAlarms() {
    _loadBoolSetting(enableAlarmsProvider, 'enable_alarms', true);
  }

  void _loadDefaultSessionDuration() {
    _loadDurationSetting(
        defaultSessionDurationProvider, 'default_session_duration_in_minutes', 120);
  }

  void _loadDefaultShortBreakInterval() {
    _loadDurationSetting(defaultShortBreaksIntervalProvider,
        'default_short_breaks_interval_in_minutes', 40);
  }

  void _loadShortBreakRemindDelay() {
    _loadDurationSetting(
        defaultShortBreaksIntervalProvider, 'short_break_remind_delay_in_minutes', 5);
  }

  void _loadSessionEndAlarmSound() {
    _loadStringSetting(
        sessionEndAlarmSoundProvider, 'session_end_alarm_sound', 'spanish_guitar');
  }

  void _loadShortBreakAlarmSound() {
    _loadStringSetting(
        shortBreakAlarmSoundProvider, 'short_break_alarm_sound', 'irish_folk');
  }
}

Future<void> loadSettings(BuildContext context, WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  if (!context.mounted) return;
  final settingsLoader = SettingsLoader(ref, context, prefs);
  await settingsLoader._loadAllSettings();
}
