import 'package:flutter/material.dart';
import 'package:mission_report_app/utils/color.dart';
import 'package:mission_report_app/utils/font.dart';

ThemeData primaryThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: AppColors.primaryMaterialColor,
    textTheme: const TextTheme(bodyText1: TextStyle(fontSize: 16)),
    textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
          selectionHandleColor: AppColors.secondary,
          selectionColor: AppColors.secondary,
        ),
    fontFamily: AppFonts.primary,
    hintColor: Colors.grey[400],
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      elevation: 0,
    ),
    iconTheme: IconThemeData(color: AppColors.icon),
  );
}

ThemeData moeThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: AppColors.moeGreenMaterialColor,
    textTheme: const TextTheme(bodyText1: TextStyle(fontSize: 16)),
    textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
          selectionHandleColor: AppColors.secondary,
          selectionColor: AppColors.secondary,
        ),
    fontFamily: AppFonts.primary,
    hintColor: Colors.grey[400],
    appBarTheme: AppBarTheme(
      color: AppColors.moeGreen,
      elevation: 0,
    ),
    iconTheme: IconThemeData(color: AppColors.icon),
  );
}
