import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/features/random_quote/presentation/cubit/quote_cubit.dart';
import 'package:quotes/features/random_quote/presentation/screens/quote_screen.dart';
import 'package:quotes/features/splash_screen/presentation/screen/splash_screen.dart';
import '../../core/utils/app_string.dart';
import '../../injection_container.dart' ;


class Routes {
  static const String initialRoute = '/';
  static const String randomQuoteRoute = '/randomQuote';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: ((context) {
          return const SplashScreen();
        }));

      case Routes.randomQuoteRoute:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) =>serviceLocator<QuoteCubit>() ,
            child: const QuoteScreen(),
          );
        });
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) =>
        const Scaffold(
          body: Center(
            child: Text(AppStrings.noRouteFound),
          ),
        )));
  }
}