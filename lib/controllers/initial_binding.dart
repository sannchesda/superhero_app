import 'package:mission_report_app/controllers/internet_check_controller.dart';
import 'package:mission_report_app/controllers/local_authentication_controller.dart';
import 'package:mission_report_app/controllers/master_data_controller.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetCheckController());
    Get.lazyPut<LocalAuthenticationController>(
      () => LocalAuthenticationController(),
      fenix: true,
    );

    Get.lazyPut(
      () => MasterDataController(),
      fenix: true,
    );
  }
}
