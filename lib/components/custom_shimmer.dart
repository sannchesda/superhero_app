import 'package:flutter/material.dart';
import 'package:flutter_boiler_plate/utils/color.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      // period: const Duration(milliseconds: 1000),
      direction: ShimmerDirection.ltr,
      baseColor: AppColors.primary.withOpacity(0.1),
      highlightColor: Colors.white.withOpacity(0.1),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white.withOpacity(0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              spreadRadius: 0.5,
            ),
          ],
        ),
        // color: ThemeColors.colorPrimaryGrey,
      ),
    );
  }
}
