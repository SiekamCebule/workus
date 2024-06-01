import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:workus/models/quote.dart';

Future<Iterable<Quote>> quotesFromJson(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => Quote.fromJson(json));
}
