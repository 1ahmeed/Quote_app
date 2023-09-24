
import 'package:quotes/core/api/end_points.dart';
import 'package:quotes/core/utils/app_string.dart';
import 'package:quotes/features/random_quote/data/models/quote_model.dart';
import '../../../../core/api/api_consumer.dart';

abstract class QuoteRemoteDataSource {
  Future<QuoteModel> getQuotes();
}

class QuoteRemoteDataSourceImpl extends QuoteRemoteDataSource {
  ApiConsumer apiConsumer;

  QuoteRemoteDataSourceImpl({required this.apiConsumer});

 @override
  Future<QuoteModel> getQuotes() async {

     var response = await apiConsumer.get(EndPoints.randomQuotes, query: {
      AppStrings.apiKey: AppStrings.key,
    });
     return  QuoteModel.fromJson(response);

  }
}
