import 'package:flutter/material.dart';

import 'app_colors.dart';

final mainTheme = ThemeData(
  useMaterial3: false,
  unselectedWidgetColor: AppColors.lightGray,
  colorScheme:
      ColorScheme.fromSwatch().copyWith(primary: AppColors.primaryBlue),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    elevation: 1,
    titleTextStyle: TextStyle(
      fontSize: 17,
      color: Colors.black,
      fontWeight: FontWeight.w500,
      height: 1.16,
    ),
  ),
  fontFamily: 'Roboto Flex',
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromRGBO(0, 137, 208, 1),
    height: 60,
  ),
  scaffoldBackgroundColor: Colors.white,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  dialogTheme: DialogTheme(
    barrierColor: Colors.black.withOpacity(0.8),
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(
      fontSize: 40,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 600)],
    ),
    labelMedium: TextStyle(
      fontSize: 24,
      height: 1.17,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 600)],
    ),
    displayLarge: TextStyle(
      fontSize: 24,
      height: 1.17,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 900)],
    ),
    displayMedium: TextStyle(
      fontSize: 24,
      height: 1.17,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 700)],
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      height: 1.2,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 700)],
    ),
    headlineLarge: TextStyle(
      fontSize: 20,
      height: 1.2,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 700)],
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      height: 1.17,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 500)],
    ),
    headlineSmall: TextStyle(
      fontSize: 16,
      height: 1.25,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 700)],
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      height: 1.25,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 400)],
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 400)],
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontVariations: [FontVariation('wght', 400)],
    ),
  ),
);
