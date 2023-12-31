import 'dart:math';
import 'package:flutter/material.dart';

class AppColors {
  /// Main Colors
  static Color primary = hexToColor("#003060");
  static MaterialColor primaryMaterialColor = generateMaterialColor(primary);
  static Color secondary = hexToColor("#0074B7");
  static Color tertiary = hexToColor("#60A3D9");

  /// Widget Colors
  static Color icon = hexToColor("#0074B7");
  static Color iconSecondary = hexToColor("#966E2A");
  static Color disableBorder = Colors.white.withOpacity(0.5);

  static Color navyBlue = hexToColor("#003060");
  static Color royalBlue = hexToColor("#0074B7");
  static Color blueGrotto = hexToColor("#60A3D9");
  static Color babyBlue = hexToColor("#BFD7ED");
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
