import 'package:dartz/dartz.dart';
import 'package:quotes/core/errors/failures.dart';
import 'package:quotes/core/use_cases/use_case.dart';
import 'package:quotes/features/splash_screen/domain/repo/lang_repo.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepo langRepo;

  ChangeLangUseCase({required this.langRepo});
  @override
  Future<Either<Failure, bool>> call(String langCode)async {
    return await langRepo.changeLang(langCode: langCode);
  }
}
