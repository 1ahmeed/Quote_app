import 'package:dartz/dartz.dart';
import 'package:quotes/core/use_cases/use_case.dart';
import 'package:quotes/features/random_quote/domain/entity/quote_entity.dart';
import 'package:quotes/features/random_quote/domain/repo/quote_repo.dart';

import '../../../../core/errors/failures.dart';

class GetQuotesUseCase implements UseCase<QuoteEntity,NoParam>{
final QuoteRepo quoteRepo;

  GetQuotesUseCase({required this.quoteRepo});

  @override
  Future<Either<Failure, QuoteEntity>> call(NoParam param) {
    return quoteRepo.getQuotes();
  }
}