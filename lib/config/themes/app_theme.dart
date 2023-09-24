
import 'package:flutter/material.dart';
import 'package:quotes/core/utils/app_color.dart';
import 'package:quotes/core/utils/app_string.dart';

ThemeData appTheme(){
  return ThemeData(
    primaryColor:AppColors.primary ,
    hintColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backGround,
    appBarTheme: AppBarTheme(
      color:Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.colorAppBarText,
        fontSize: 20,
        fontWeight: FontWeight.bold
      )
    ),
    brightness: Brightness.light,
    fontFamily: AppStrings.fontFamily,
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: AppColors.backGround,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        height: 1.5,
      ),
    )

  );
}