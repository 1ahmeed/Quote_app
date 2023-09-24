part of 'quote_cubit.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
// TODO: implement props
  List<Object?> get props => [];
}

class QuoteInitial extends QuoteState {}

class QuoteLoadingState extends QuoteState {}

class QuoteSuccessState extends QuoteState {
  final QuoteEntity quoteEntity;

  const QuoteSuccessState({required this.quoteEntity});
  @override
  List<Object?> get props => [quoteEntity];
}

class QuoteErrorState extends QuoteState {
  final String errorMessage;

  const QuoteErrorState({required this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
