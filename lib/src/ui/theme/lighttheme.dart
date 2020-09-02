import 'package:flutter/material.dart';
import 'package:lazy_loading_list/src/assets/app_colors.dart';

ThemeData llightTheme() {
  return ThemeData(
    fontFamily: 'NotoSansJP-Medium',
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    primaryTextTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 25,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 20,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold),
      headline3: TextStyle(
          fontSize: 16,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold),
      headline4: TextStyle(
        color: AppColors.boldtextColor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      bodyText1: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 25,
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
          fontSize: 20,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold),
      headline3: TextStyle(
          fontSize: 16,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold),
      headline4: TextStyle(
        color: AppColors.boldtextColor,
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
