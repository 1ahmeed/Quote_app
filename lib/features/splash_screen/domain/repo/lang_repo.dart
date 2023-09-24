import 'package:dartz/dartz.dart';
import 'package:quotes/core/errors/failures.dart';

abstract class LangRepo{

  Future<Either<Failure,bool>> changeLang({required String langCode});
  Future<Either<Failure,String>> getSavedLang();
}