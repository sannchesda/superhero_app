import 'dart:math';
import 'package:flutter/material.dart';

class AppColors {
  /// Main Colors
  static Color primary = hexToColor("#077F36");
  static MaterialColor primaryMaterialColor = generateMaterialColor(primary);
  static Color secondary = hexToColor("#8FBFFA");
  static Color tertiary = hexToColor("#FFF200");

  /// Widget Colors
  static Color icon = hexToColor("#8FBFFA");
  static Color iconSecondary = hexToColor("#8FBFFA");
  static Color disableBorder = Colors.white.withOpacity(0.5);

  /// Colors
  static Color cppPurple = hexToColor("#2E3192");
  static MaterialColor cppPurpleMaterialColor =
      generateMaterialColor(cppPurple);
  static Color blue = hexToColor("#1e73be");
  static Color lightBlue = hexToColor("#8FBFFA");
  static Color yellow = hexToColor("#FFF200");
  static final Color mptcBlue = hexToColor("#003d7c");
  static final Color mptcYellow = hexToColor("#ef7c00");
  static final Color eMeetingBlue = hexToColor("#0E3759");
  static final Color borderColor = Colors.black.withOpacity(0.5);
  static final Color grey = Colors.black.withOpacity(0.5);
  static const Color lightGrey = Color.fromRGBO(46, 49, 146, 0.10);
  static final Color red = hexToColor("#FF000080");
  static final Color moeGreen = hexToColor("#077F36");
  static MaterialColor moeGreenMaterialColor = generateMaterialColor(moeGreen);

  // MOE Color Palettes
  static const Color first = Color.fromRGBO(7, 127, 54, 0.5);
  static const Color second = Color.fromRGBO(7, 219, 158, 0.86);
  static const Color third = Color.fromRGBO(19, 242, 231, 0.95);
  static const Color fourth = Color.fromRGBO(7, 173, 219, 0.86);
  static const Color fifth = Color.fromRGBO(7, 133, 249, 0.98);
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

int tintValue(int value, double factor) {
  return max(0, min((value + ((255 - value) * factor)).round(), 255));
}

Color tintColor(Color color, double factor) {
  return Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1,
  );
}

int shadeValue(int value, double factor) {
  return max(0, min(value - (value * factor).round(), 255));
}

Color shadeColor(Color color, double factor) {
  return Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1,
  );
}
