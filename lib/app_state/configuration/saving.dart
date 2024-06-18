import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workus/app_state/configuration/settings.dart';

class SettingsSaver {
  final WidgetRef _ref;
  final SharedPreferences _prefs;

  SettingsSaver(this._ref, this._prefs);

  static Future<void> save(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsSaver = SettingsSaver(ref, prefs);
    await settingsSaver._saveAllSettings();
  }

  Future<void> _saveAllSettings() async {
    _saveLanguage();
    _saveShowQuotes();
    _saveShowIncompletedTasksWarnings();
    _saveEnableNavigationRailExtendEffect();
    _saveExtendNavigationRail();
    _saveShowNotifications();
    _saveEnableAlarms();
    _saveDefaultSessionDuration();
    _saveDefaultShortBreakInterval();
    _saveSessionEndAlarmSound();
    _saveShortBreakAlarmSound();
  }

  void _saveBoolSetting(StateProvider<bool> provider, String key) {
    final value = _ref.read(provider);
    _prefs.setBool(key, value);
  }

  void _saveLanguage() {
    final lang = _ref.read(languageProvider);
    _prefs.setString('language', lang.code);
  }

  void _saveShowQuotes() {
    _saveBoolSetting(shouldShowQuotesProvider, 'should_show_quotes');
  }

  void _saveShowIncompletedTasksWarnings() {
    _saveBoolSetting(shouldShowIncompletedTasksWarningsProvider,
        'should_show_incompleted_tasks_warnings');
  }

  void _saveEnableNavigationRailExtendEffect() {
    _saveBoolSetting(
        enableNavigationRailExtendEffectProvider, 'enable_navigation_rail_extend_effect');
  }

  void _saveExtendNavigationRail() {
    _saveBoolSetting(shouldExtendNavigationRailProvider, 'should_extend_navigation_rail');
  }

  void _saveShowNotifications() {
    _saveBoolSetting(shouldShowNotificationsProvider, 'should_show_notifications');
  }

  void _saveEnableAlarms() {
    _saveBoolSetting(enableAlarmsProvider, 'enable_alarms');
  }

  void _saveDefaultSessionDuration() {
    final defaultSessionDuration = _ref.read(defaultSessionDurationProvider);
    _prefs.setInt(
        'default_session_duration_in_minutes', defaultSessionDuration.inMinutes);
  }

  void _saveDefaultShortBreakInterval() {
    final defaultShortBreakInterval = _ref.read(defaultShortBreaksIntervalProvider);
    _prefs.setInt(
        'default_short_breaks_interval_in_minutes', defaultShortBreakInterval.inMinutes);
  }

  void _saveSessionEndAlarmSound() {
    final sessionEndAlarm = _ref.read(sessionEndAlarmSoundProvider);
    _prefs.setString('session_end_alarm_sound', sessionEndAlarm!.id);
  }

  void _saveShortBreakAlarmSound() {
    final shortBreakAlarm = _ref.read(shortBreakAlarmSoundProvider);
    _prefs.setString('short_break_alarm_sound', shortBreakAlarm!.id);
  }
}

Future<void> saveSettings(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final settingsSaver = SettingsSaver(ref, prefs);
  await settingsSaver._saveAllSettings();
}
