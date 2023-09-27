import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateFormat {
  static final englishDayNameFormat = DateFormat("EEEE", "en");
  static final khmerDayNameFormat = DateFormat("EEEE", "km");

  static final dateMonthNameFormat = DateFormat("dd-MMMM-yyyy", "km");
  static final dateFormat = DateFormat('dd-MM-yyyy');
  static final timeFormat = DateFormat('hh:mm a');
  static final dateTimeMonthNameFormat = DateFormat('dd-MMMM-yyyy hh:mm:ss');
  static final apiDateFormat = DateFormat('yyyy-MM-dd');
}

class StorageKey {
  static const String accessTokenKeyStorage = "ACCESS_TOKEN";

  static const String biometricEnrollmentKeyName =
      "BIOMETRIC_ENROLLMENT_KEY_STORAGE";
  static const String pinCodeEnrollmentKeyName = "IS_ENROLLED_PIN_CODE";
  static const String pinCodeKeyName = "PIN_CODE";
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class AssetDir {
  static const String image = "assets/images";
  static const String font = "assets/fonts";
  static const String icon = "assets/icons";
}

class AppStaticValue {
  static const double cardBorderRadius = 10;
  static const double maxConstraintWidth = 425.0;
  static const double homeAppBarSize = 180;
  static const int bottomSheetDuration = 250; // in Millisecond
  static const int delayDuration = 200; // in Millisecond
  static final DateTime now = DateTime.now();
  static final DateTime nowMonthYear = DateTime(now.year, now.month);

  EdgeInsets get textFieldContentPadding => const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      );
}

class RemoteConfigKey {
  static const String appConfigKey = "cpp";
  static const String configKey = "config";
  static const String appVersionKey = "appVersion";
}
