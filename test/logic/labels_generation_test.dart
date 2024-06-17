import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workus/utils/labels.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  testWidgets('labelForSessionRemainingTime', (WidgetTester tester) async {
    // Create a helper widget to provide the BuildContext
    final testWidget = Builder(
      builder: (BuildContext context) {
        return Container();
      },
    );

    // Pump the widget with the Polish locale
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pl', 'PL'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pl', 'PL'),
        ],
        home: testWidget,
      ),
    );

    final BuildContext context = tester.element(find.byType(Container));

    // Now run the tests with the context
    expect(
      labelForDuration(context, const Duration(hours: 2, minutes: 24, seconds: 58)),
      '2 godz. 24 min. 58 sek.',
    );
    expect(
      labelForDuration(context, const Duration(hours: 2, minutes: 0, seconds: 58)),
      '2 godz. 00 min. 58 sek.',
    );
    expect(
      labelForDuration(context, const Duration(hours: 2, minutes: 24, seconds: 0)),
      '2 godz. 24 min.',
    );
    expect(
      labelForDuration(context, const Duration(hours: 2)),
      '2 godz.',
    );
    expect(
      labelForDuration(context, const Duration(hours: 2, minutes: 24, seconds: 0),
          excludeSeconds: true),
      '2 godz. 24 min.',
    );
    expect(
      labelForDuration(context, const Duration(hours: 2, minutes: 24, seconds: 58),
          excludeSeconds: true),
      '2 godz. 24 min.',
    );
    expect(
      labelForDuration(context, const Duration(minutes: 24, seconds: 58)),
      '24 min. 58 sek.',
    );
    expect(
      labelForDuration(context, const Duration(minutes: 24, seconds: 0)),
      '24 min.',
    );
    expect(
      labelForDuration(context, const Duration(seconds: 58)),
      '58 sek.',
    );
    expect(
      labelForDuration(context, const Duration(hours: 15)),
      '15 godz.',
    );
    expect(
      labelForDuration(context, Duration.zero),
      '0 min.',
    );
  });
}
