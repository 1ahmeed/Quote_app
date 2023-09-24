import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/core/use_cases/use_case.dart';
import 'package:quotes/core/utils/app_string.dart';
import 'package:quotes/features/splash_screen/domain/use_case/change_lang_use_case.dart';
import 'package:quotes/features/splash_screen/domain/use_case/get_saved_lang_use_case.dart';

import 'local_state.dart';



class LocalCubit extends Cubit<LocalState> {
  LocalCubit({
        required this.getSavedLangUseCase,
        required this.changeLangUseCase,
      })
      : super(const ChangeLocalState(Locale(AppStrings.englishCode)));

  static LocalCubit? get(context) => BlocProvider.of(context);

  final GetSavedLangUseCase getSavedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  String currentLangCode = AppStrings.englishCode;

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParam());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = value;
      emit(ChangeLocalState(Locale(currentLangCode)));
    });
  }

  Future<void> changeLang({required String langCode}) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLangCode = langCode;
      if(currentLangCode==AppStrings.englishCode){
        emit(ChangeLocalState(Locale(currentLangCode)));
      }else{
        emit(ChangeLocalState(Locale(currentLangCode)));
      }

    });
  }

  void toArabic()=>changeLang(langCode: AppStrings.arabicCode);
  void toEnglish()=>changeLang(langCode: AppStrings.englishCode);
}

