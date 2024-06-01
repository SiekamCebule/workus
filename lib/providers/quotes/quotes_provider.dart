import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/quote.dart';
import 'package:workus/providers/quotes/quotes_notifier.dart';

final buddhistQuotesProvider = AsyncNotifierProvider<QuotesNotifier, Set<Quote>>(() {
  return QuotesNotifier();
});

final humorousQuotesProvider = AsyncNotifierProvider<QuotesNotifier, Set<Quote>>(() {
  return QuotesNotifier();
});

final ironicQuotesProvider = AsyncNotifierProvider<QuotesNotifier, Set<Quote>>(() {
  return QuotesNotifier();
});

final motivatingQuotesProvider = AsyncNotifierProvider<QuotesNotifier, Set<Quote>>(() {
  return QuotesNotifier();
});

final quotesProvider = AsyncNotifierProvider<QuotesNotifier, Set<Quote>>(() {
  return QuotesNotifier();
});
