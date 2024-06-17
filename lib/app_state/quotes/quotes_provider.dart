import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/quote.dart';
import 'package:workus/app_state/quotes/quotes_notifier.dart';

final quotesProvider = AsyncNotifierProvider<QuotesNotifier, Set<Quote>>(() {
  return QuotesNotifier();
});
