import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes/core/api/api_consumer.dart';
import 'package:quotes/core/api/dio_consumer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/api/app_interceptors.dart';
import 'core/network/network_info.dart';
import 'features/random_quote/data/data_sources/quote_local_data_source.dart';
import 'features/random_quote/data/data_sources/quote_remote_data_source.dart';
import 'features/random_quote/data/repo_impl/quote_repo_impl.dart';
import 'features/random_quote/domain/repo/quote_repo.dart';
import 'features/random_quote/domain/use_cases/get_quotes_use_case.dart';
import 'features/random_quote/presentation/cubit/quote_cubit.dart';
import 'features/splash_screen/data/data_sources/lang_local_data_source.dart';
import 'features/splash_screen/data/repo_impl/lang_repo_impl.dart';
import 'features/splash_screen/domain/repo/lang_repo.dart';
import 'features/splash_screen/domain/use_case/change_lang_use_case.dart';
import 'features/splash_screen/domain/use_case/get_saved_lang_use_case.dart';
import 'features/splash_screen/presentation/cubit/local_cubit.dart';

final serviceLocator = GetIt.instance;
///cubit
/// usecase
/// repoimpl
/// remote local data source
/// core[api- network info]
Future<void> initServiceLocator() async {
  //! Features

  // Blocs
  serviceLocator.registerFactory<QuoteCubit>(
          () => QuoteCubit(getQuotesUseCase: serviceLocator()));
  serviceLocator.registerFactory<LocalCubit>(
          () => LocalCubit(getSavedLangUseCase: serviceLocator(), changeLangUseCase: serviceLocator()));

  ///
  // Use cases
  serviceLocator.registerLazySingleton<GetQuotesUseCase>(
          () => GetQuotesUseCase(quoteRepo: serviceLocator()));
  serviceLocator.registerLazySingleton<GetSavedLangUseCase>(
          () => GetSavedLangUseCase(langRepo: serviceLocator()));
  serviceLocator.registerLazySingleton<ChangeLangUseCase>(
          () => ChangeLangUseCase(langRepo: serviceLocator()));

  // Repository
  serviceLocator.registerLazySingleton<QuoteRepo>(() => QuoteRepoImpl(
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator()));
  serviceLocator.registerLazySingleton<LangRepo>(
          () => LangRepoImpl(langLocalDataSource: serviceLocator()));

  // Data Sources
  serviceLocator.registerLazySingleton<QuoteLocalDataSource>(
          () => QuoteLocalDataSourceImpl(sharedPreferences: serviceLocator()));
  serviceLocator.registerLazySingleton<QuoteRemoteDataSource>(
          () => QuoteRemoteDataSourceImpl(apiConsumer: serviceLocator()));
  serviceLocator.registerLazySingleton<LangLocalDataSource>(
          () => LangLocalDataSourceImpl(sharedPreferences: serviceLocator()));

  //! Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(internetConnectionChecker: serviceLocator()));
  serviceLocator.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: serviceLocator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => AppInterceptors());
  serviceLocator.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  serviceLocator.registerLazySingleton(() => Dio());
}
