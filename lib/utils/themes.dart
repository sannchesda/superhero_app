import 'package:flutter/material.dart';
import 'package:superhero_app/utils/color.dart';
import 'package:superhero_app/utils/font.dart';

ThemeData primaryThemeData(BuildContext context) {
  return ThemeData(
    primarySwatch: AppColors.primaryMaterialColor,
    textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 16)),
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

