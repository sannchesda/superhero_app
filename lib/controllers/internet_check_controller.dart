import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mission_report_app/utils/functions.dart';
import 'package:get/get.dart';

class InternetCheckController extends GetxController {
  ConnectivityResult connectionStatus = ConnectivityResult.wifi;
  final Connectivity connectivity = Connectivity();

  bool isTryAgain = false;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    connectivity.onConnectivityChanged.listen(onConnectivityChange);
  }

  void onConnectivityChange(result) {
    final preResult = connectionStatus;
    final currentStatus = result;

    if (preResult == ConnectivityResult.none &&
        currentStatus != ConnectivityResult.none) {
      if (Get.context != null) {
        showSnackbar(Get.context!, "internet_restore".tr);
      }
    } else if (result == ConnectivityResult.none) {
      if (Get.context != null) {
        showSnackbar(Get.context!, "no_internet_title".tr);
      }
    }
    connectionStatus = result;
  }

  void initConnectivity() async {
    try {
      final connectivityResult = await connectivity.checkConnectivity();
      connectionStatus = connectivityResult;
      if (connectionStatus == ConnectivityResult.none) {
        if (Get.context != null) {
          showSnackbar(Get.context!, "no_internet_title".tr);
        }
        return;
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return;
    }
  }

  void checkInternet() {
    Connectivity().checkConnectivity().then((result) {
      final preResult = connectionStatus;
      final currentStatus = result;

      if (preResult == ConnectivityResult.none &&
          currentStatus != ConnectivityResult.none) {
        if (Get.context != null) {
          showSnackbar(Get.context!, "internet_restore".tr);
        }
      } else if (result == ConnectivityResult.none) {
        if (Get.context != null) {
          showSnackbar(Get.context!, "no_internet_title".tr);
        }
      }
      connectionStatus = result;
      update();
    });
  }
}
