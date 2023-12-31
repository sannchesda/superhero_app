import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superhero_app/service/app_service/localization_service.dart';
import 'package:superhero_app/utils/constant.dart';
import 'package:superhero_app/views/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LocalizationService().getLocale();
    });
    goToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 175,
              width: 175,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset("${AssetDir.image}/app_icon.png"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> goToHome() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(() => const HomePage());
  }
}
