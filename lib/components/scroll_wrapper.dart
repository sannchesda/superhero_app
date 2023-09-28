import 'package:flutter/material.dart';

class ScrollWrapper extends StatelessWidget {
  const ScrollWrapper({
    super.key,
    this.onRefresh,
    required this.child,
    this.hasScrollBody = false,
  });

  final Future<void> Function()? onRefresh;
  final Widget child;
  final bool hasScrollBody;

  @override
  Widget build(BuildContext context) {
    final mainWidget = CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: hasScrollBody,
          child: child,
        ),
      ],
    );
    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        child: mainWidget,
      );
    }
    return mainWidget;
  }
}
