import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Text(text ?? "no_data".tr),
    );
  }
}
