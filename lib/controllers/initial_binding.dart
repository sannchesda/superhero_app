
import 'package:get/get.dart';
import 'package:superhero_app/controllers/internet_check_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(InternetCheckController());
  }
}
