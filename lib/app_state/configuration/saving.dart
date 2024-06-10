import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workus/app_state/configuration/settings.dart';

class SettingsSaver {
  final WidgetRef _ref;
  final SharedPreferences _prefs;

  SettingsSaver(this._ref, this._prefs);

  void _saveBoolSetting(StateProvider<bool> provider, String key) {
    final value = _ref.read(provider);
    _prefs.setBool(key, value);
  }

  void _saveEnableNavigationRailExtendEffect() {
    _saveBoolSetting(
        enableNavigationRailExtendEffectProvider, 'enable_navigation_rail_extend_effect');
  }

  void _saveExtendNavigationRail() {
    _saveBoolSetting(extendNavigationRailProvider, 'extend_navigation_rail');
  }

  void _saveShowQuotes() {
    _saveBoolSetting(shouldShowQuotesProvider, 'show_quotes');
  }

  void _saveShowIncompletedTasksWarnings() {
    _saveBoolSetting(
        shouldShowIncompletedTasksWarningsProvider, 'show_incompleted_tasks_warnings');
  }

  void _saveShortBreakAlarmSound() {
    final shortBreakAlarm = _ref.read(shortBreakAlarmSoundProvider);
    _prefs.setString('short_break_alarm_sound', shortBreakAlarm.id);
  }

  void _saveSessionEndAlarmSound() {
    final sessionEndAlarm = _ref.read(sessionEndAlarmSoundProvider);
    _prefs.setString('session_end_alarm_sound', sessionEndAlarm.id);
  }

  void _saveShortBreakRemindDelay() {
    final shortBreakRemindDelay = _ref.read(defaultShortBreaksIntervalProvider);
    _prefs.setInt('short_break_remind_delay_in_minutes', shortBreakRemindDelay.inMinutes);
  }

  void _saveDefaultShortBreakInterval() {
    final defaultShortBreakInterval = _ref.read(defaultShortBreaksIntervalProvider);
    _prefs.setInt(
        'default_short_breaks_interval_in_minutes', defaultShortBreakInterval.inMinutes);
  }

  void _saveDefaultSessionDuration() {
    final defaultSessionDuration = _ref.read(defaultSessionDurationProvider);
    _prefs.setInt(
        'default_session_duration_in_minutes', defaultSessionDuration.inMinutes);
  }

  Future<void> _saveAllSettings() async {
    _saveShowQuotes();
    _saveShowIncompletedTasksWarnings();
    _saveDefaultSessionDuration();
    _saveDefaultShortBreakInterval();
    _saveShortBreakRemindDelay();
    _saveSessionEndAlarmSound();
    _saveShortBreakAlarmSound();
    _saveEnableNavigationRailExtendEffect();
    _saveExtendNavigationRail();
  }

  static Future<void> save(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    final settingsSaver = SettingsSaver(ref, prefs);
    await settingsSaver._saveAllSettings();
  }
}

Future<void> saveSettings(WidgetRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  final settingsSaver = SettingsSaver(ref, prefs);
  await settingsSaver._saveAllSettings();
}
