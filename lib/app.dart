import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/config/locale/app_localizations_setup.dart';
import 'package:quotes/core/utils/app_string.dart';
import 'package:quotes/features/splash_screen/presentation/cubit/local_cubit.dart';
import 'package:quotes/injection_container.dart';
import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'features/splash_screen/presentation/cubit/local_state.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal(); //singleton
  factory MyApp()=> _instance;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<LocalCubit>()..getSavedLang())
      ],
      child: BlocBuilder<LocalCubit, LocalState>(
        buildWhen: (previousState,currentState){
          return previousState != currentState;
        },
        builder: (context, state) {
          return MaterialApp(
            title: AppStrings.appName,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            theme: appTheme(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
            supportedLocales: AppLocalizationsSetup.supportedLocales,
            localeResolutionCallback:
            AppLocalizationsSetup.localeResolutionCallback,
            localizationsDelegates:
            AppLocalizationsSetup.localizationsDelegates,

          );
        },
      ),
    );
  }
}