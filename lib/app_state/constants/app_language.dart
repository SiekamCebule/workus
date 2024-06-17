enum AppLanguage {
  polish,
  english,
  french,
  italic,
  albanian,
  german,
  spanish;

  static AppLanguage fromCode(String code) {
    return langCodes.entries
        .firstWhere(
          (entry) => entry.value == code,
          orElse: () => throw ArgumentError(
            'Invalid language code: $code',
          ),
        )
        .key;
  }

  String get code => langCodes[this]!;
  String get name => langNames[this]!;
}

final langCodes = {
  AppLanguage.polish: 'pl',
  AppLanguage.english: 'en',
  AppLanguage.french: 'fr',
  AppLanguage.italic: 'it',
  AppLanguage.albanian: 'sq',
  AppLanguage.german: 'de',
  AppLanguage.spanish: 'es',
};

final langNames = {
  AppLanguage.polish: 'Polski',
  AppLanguage.english: 'English',
  AppLanguage.french: 'Français',
  AppLanguage.italic: 'Italiano',
  AppLanguage.albanian: 'Shqip',
  AppLanguage.german: 'Deutsch',
  AppLanguage.spanish: 'Español',
};
