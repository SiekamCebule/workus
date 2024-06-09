import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/quote.dart';
import 'package:workus/app_state/quotes/quotes_json.dart';

class QuotesNotifier extends AsyncNotifier<Set<Quote>> {
  final _random = Random();

  @override
  Future<Set<Quote>> build() async {
    return {};
  }

  Future<void> loadFromJson(String jsonFile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final quotes = await quotesFromJson(jsonFile);
      return quotes.toSet();
    });
  }

  Future<void> addAllFromProvider(
    AsyncNotifierProvider<QuotesNotifier, Set<Quote>> provider,
  ) async {
    final asyncQuotes = ref.read(provider.future);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final quotesToAdd = await asyncQuotes;
      final currentQuotes = state.value ?? <Quote>{};
      final unioned = currentQuotes.union(quotesToAdd);
      return unioned;
    });
  }

  void addAll(Set<Quote> quotes) {
    state = state.whenData((existingQuotes) {
      return {
        ...existingQuotes,
        ...quotes,
      };
    });
  }

  void add(Quote quote) {
    state = state.whenData((existingQuotes) {
      return {
        ...existingQuotes,
        quote,
      };
    });
  }

  void remove(Quote toRemove) {
    state = state.whenData((existingQuotes) {
      return existingQuotes.where(
        (quote) {
          return quote != toRemove;
        },
      ).toSet();
    });
  }

  int get length {
    return state.whenData((quotes) => quotes.length).value ?? 0;
  }

  Quote randomQuote() {
    final quotes = state.whenData((quotes) => quotes).value;
    if (quotes == null) {
      throw StateError('No quotes, so cannot get the random one');
    } else {
      return quotes.elementAt(_random.nextInt(length));
    }
  }
}
