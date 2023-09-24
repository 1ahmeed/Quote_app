import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entity/quote_entity.dart';

abstract class QuoteRepo{
  Future<Either<Failure, QuoteEntity>> getQuotes();
}