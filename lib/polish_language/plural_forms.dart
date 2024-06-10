String getPolishPluralForm(
    int number, String singular, String plural, String pluralGenitive) {
  if (number == 1) {
    return singular;
  } else if (number >= 2 && number <= 4) {
    return plural;
  } else {
    return pluralGenitive;
  }
}
