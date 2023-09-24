import 'dart:convert';

import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/app_string.dart';

abstract class QuoteLocalDataSource {
  Future<QuoteModel> getQuotes();

  Future<void> cacheQuotes(QuoteModel quoteModel);
}

class QuoteLocalDataSourceImpl extends QuoteLocalDataSource {
  final SharedPreferences sharedPreferences;

  QuoteLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<QuoteModel> getQuotes() {
    final jsonString =
        sharedPreferences.getString(AppStrings.cacheRandomQuotes);
    if (jsonString != null) {
      final cacheRandomQuote =
          Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cacheRandomQuote;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheQuotes(QuoteModel quoteModel) {
    return sharedPreferences.setString(
        AppStrings.cacheRandomQuotes, json.encode(quoteModel));
  }
}
