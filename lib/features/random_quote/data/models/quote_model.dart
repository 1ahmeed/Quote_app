import 'package:quotes/features/random_quote/domain/entity/quote_entity.dart';

// ignore: must_be_immutable
class QuoteModel extends QuoteEntity{


  QuoteModel({
      this.content1,
      this.author1,
      this.category1,}):super(
    content: content1,
    author: author1,
    category: category1,
  );

  factory QuoteModel.fromJson(Map<String,dynamic> json)=>QuoteModel(
       content1 : json['content'],
       author1 : json['author'],
      category1 : json['category'],
  );


  String? content1;
   String? author1;
   String? category1;



  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['quote'] = content1;
    map['author'] = author1;
    map['category'] = category1;
    return map;
  }

}