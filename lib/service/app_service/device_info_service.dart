import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoService {
  static String uuid = 'unknown';
  static late String? osVersion;
  static late String platform;
  static late String appVersion;
  static late String deviceType;
  static late String deviceName;
  static late String model;
  static late String appName;

  static dynamic initialize() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    appVersion = packageInfo.version;
    appName = packageInfo.appName;

    if (GetPlatform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      uuid = androidInfo.id ?? "";
      osVersion = androidInfo.version.release;
      platform = 'android';
      // deviceName = androidInfo.model ?? "";
      deviceName = "Android Device Name";
      model = androidInfo.model ?? "";
      deviceType = "Phone";
    } else if (GetPlatform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      uuid = iosInfo.identifierForVendor ??
          '${iosInfo.systemName}${iosInfo.model}${iosInfo.name}';
      osVersion = iosInfo.systemVersion;
      platform = 'ios';
      // deviceName = iosInfo.name ?? "";
      deviceName = "iOS Device Name";
      model = iosInfo.model ?? "";
      deviceType = "Phone";
    }
  }
}
