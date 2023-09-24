import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/use_cases/use_case.dart';
import 'package:quotes/core/utils/app_string.dart';
import 'package:quotes/features/random_quote/domain/entity/quote_entity.dart';
import 'package:quotes/features/random_quote/domain/use_cases/get_quotes_use_case.dart';

import '../../../../core/errors/failures.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit({required this.getQuotesUseCase}) : super(QuoteInitial());

  static QuoteCubit? get(context) => BlocProvider.of(context);

  final GetQuotesUseCase getQuotesUseCase;

  Future<void> getRandomQuote() async {
    Either<Failure, QuoteEntity> response =
        await getQuotesUseCase.call(NoParam());
    response.fold((failure) {
      emit(QuoteErrorState(errorMessage: mapFailureToString(failure)));
    }, (quoteEntity) {
      emit(QuoteSuccessState(quoteEntity: quoteEntity));
    });
  }

  String mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unExpectedError;
    }
  }
}
