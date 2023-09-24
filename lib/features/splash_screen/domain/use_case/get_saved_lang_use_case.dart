import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repo/lang_repo.dart';

class GetSavedLangUseCase implements UseCase< String,NoParam> {
  final LangRepo langRepo;

  GetSavedLangUseCase({required this.langRepo});
  @override
  Future<Either<Failure, String>> call(NoParam param)async {
    return await langRepo.getSavedLang();
  }
}

