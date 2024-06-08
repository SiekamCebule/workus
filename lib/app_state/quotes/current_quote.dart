import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workus/models/quote.dart';

final currentQuoteProvider = StateProvider<Quote?>((ref) => null);
