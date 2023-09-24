import 'package:equatable/equatable.dart';

class QuoteEntity extends Equatable{
  final String? author;
  final String? content;
  final String? category;

  const QuoteEntity({
    required this.author,
    required this.content,
    required this.category,});
  @override
  List<Object?> get props => [author,content,category];

}