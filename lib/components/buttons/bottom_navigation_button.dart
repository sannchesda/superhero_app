import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigationButton extends StatelessWidget {
  const BottomNavigationButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: Get.width,
        height: kBottomNavigationBarHeight,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
