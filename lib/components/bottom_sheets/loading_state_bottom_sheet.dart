import 'package:flutter/material.dart';
import 'package:superhero_app/components/custom_shimmer.dart';

class LoadingStateBottomSheet extends StatelessWidget {
  const LoadingStateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 5);
      },
      itemCount: 5,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: SizedBox(
                    height: 16 * 1.5,
                    child: ShimmerWidget(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
          ],
        );
      },
    );
  }
}
