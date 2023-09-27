import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/utils/color.dart';
import 'package:flutter_boiler_plate/utils/constant.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

Future<void> showSuccessDialog({
  bool autoPop = true,
  String? title,
  String? subtitle,
}) async {
  await Get.dialog(
    barrierDismissible: true,
    CustomStatusDialog(
      title: title ?? "success_title".tr,
      message: subtitle ?? "success_message".tr,
      icon: SvgPicture.asset("${AssetDir.icon}/success.svg"),
      buttonData: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            "agree".tr,
            style: TextStyle(
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    ),
  );
  if (autoPop) {
    Get.back();
  }
}

Future<void> showFailDialog() async {
  await Get.dialog(
    barrierDismissible: true,
    CustomStatusDialog(
      title: "fail_title".tr,
      message: "fail_message".tr,
      icon: SvgPicture.asset("${AssetDir.icon}/fail.svg"),
      buttonData: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "try_again".tr,
            style: TextStyle(
              color: AppColors.secondary,
            ),
          ),
        ),
      ],
    ),
  );
}

class CustomStatusDialog extends StatelessWidget {
  const CustomStatusDialog({
    Key? key,
    this.title,
    this.message,
    this.icon,
    this.buttonData,
  }) : super(key: key);

  final String? title;
  final String? message;
  final Widget? icon;
  final List<Widget>? buttonData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white,
              ),
              padding: const EdgeInsets.only(
                top: 21,
                left: 10,
                right: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        icon ?? const SizedBox(),
                        const SizedBox(height: 10),
                        Text(
                          title ?? "",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          message ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ...List.generate(
                            buttonData?.length ?? 0,
                            (index) =>
                                buttonData?[index] ?? const SizedBox()).toList()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
