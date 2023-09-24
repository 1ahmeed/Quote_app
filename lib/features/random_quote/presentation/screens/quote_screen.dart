import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quotes/config/locale/app_localizations.dart';
import 'package:quotes/core/utils/app_color.dart';
import 'package:quotes/features/random_quote/presentation/cubit/quote_cubit.dart';
import 'package:quotes/features/splash_screen/presentation/cubit/local_cubit.dart';

import '../../../../core/widgets/error_screen.dart';
import '../widgets/quote_content.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  getQuotes() {
    QuoteCubit.get(context)?.getRandomQuote();
  }

  @override
  void initState() {
    getQuotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        icon:  Icon(Icons.translate_outlined,color: AppColors.primary,),
        onPressed: (){
          if(AppLocalizations.of(context)!.isEnLocale){
            LocalCubit.get(context)!.toArabic();
          }else{
             LocalCubit.get(context)!.toEnglish();
      }
        },
      ),
      title:  Text(AppLocalizations.of(context)!.translate("app_name")!),
    );
    return RefreshIndicator(
      onRefresh: () => getQuotes(),
      child: Scaffold(
        appBar: appBar,
        body: buildBodyContent(),
      ),
    );
  }

  Widget buildBodyContent() {
    return BlocConsumer<QuoteCubit, QuoteState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is QuoteErrorState) {
          return  ErrorScreen(
            onPress: () => QuoteCubit.get(context)!.getRandomQuote(),
          );
        } else if (state is QuoteSuccessState) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QuoteContent(quoteEntity: state.quoteEntity),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  getQuotes();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.primary, shape: BoxShape.circle),
                  child: Icon(
                    Icons.refresh,
                    color: AppColors.backGround,
                  ),
                ),
              )
            ],
          );
        } else {
          return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primary,
              ));
        }
      },
    );
  }
}
