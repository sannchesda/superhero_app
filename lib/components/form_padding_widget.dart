import 'package:flutter/material.dart';

class FormPaddingWidget extends StatelessWidget {
  const FormPaddingWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 8),
      ],
    );
  }
}
