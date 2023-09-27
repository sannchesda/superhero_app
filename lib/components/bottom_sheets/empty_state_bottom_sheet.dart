import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyStateBottomSheet extends StatelessWidget {
  const EmptyStateBottomSheet({
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
