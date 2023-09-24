import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_color.dart';
import 'package:quotes/features/random_quote/domain/entity/quote_entity.dart';

class QuoteContent extends StatelessWidget {
  const  QuoteContent({ required this.quoteEntity,Key? key}) : super(key: key);
 final QuoteEntity quoteEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.primary, borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Text(
             quoteEntity.content ??
                "sorry, No Content",
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15,),
          Text(
             quoteEntity.author??
                "unKnown",
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
