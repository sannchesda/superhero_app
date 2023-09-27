import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    this.title,
    this.subtitle,
    this.onCancel,
    this.onConfirm,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final VoidCallback? onCancel;
  final VoidCallback? onConfirm;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          width: double.infinity,
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Text(
                    title ?? "Do you want to that ?",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onCancel ?? () => Get.back(),
                    child: Text("no".tr),
                  ),
                  TextButton(
                    onPressed: onConfirm ?? () => Get.back(),
                    child: Text("yes".tr),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
