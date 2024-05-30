import 'package:flutter_test/flutter_test.dart';
import 'package:workus/utils/labels.dart';

void main() {
  test('labelForSessionRemainingTime', () {
    expect(
      labelForHMSDuration(const Duration(hours: 2, minutes: 24, seconds: 58)),
      '2 godz. 24 min. 58 sek.',
    );
    expect(
      labelForHMSDuration(const Duration(hours: 2, minutes: 0, seconds: 58)),
      '2 godz. 00 min. 58 sek.',
    );
    expect(
      labelForHMSDuration(const Duration(hours: 2, minutes: 24, seconds: 0)),
      '2 godz. 24 min. 00 sek.',
    );
    expect(
      labelForHMSDuration(const Duration(hours: 2)),
      '2 godz. 00 min. 00 sek.',
    );
    expect(
      labelForHMSDuration(const Duration(minutes: 24, seconds: 58)),
      '24 min. 58 sek.',
    );
    expect(
      labelForHMSDuration(const Duration(minutes: 24, seconds: 0)),
      '24 min. 00 sek.',
    );
    expect(
      labelForHMSDuration(const Duration(seconds: 58)),
      '58 sek.',
    );
    expect(
      labelForHMSDuration(const Duration(hours: 15)),
      '15 godz. 00 min. 00 sek.',
    );
    expect(
      labelForHMSDuration(Duration.zero),
      '0 min.',
    );
  });
}
