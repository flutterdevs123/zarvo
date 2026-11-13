import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final bool disableScroll; // Agar kisi specific screen pe scroll nahi chahiye

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.disableScroll = false,
  });

  @override
  Widget build(BuildContext context) {
    // Orientation (Portrait/Landscape) ke mutabiq screen rebuild hogi
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          Widget content = ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: IntrinsicHeight(child: child),
          );

          return disableScroll
              ? content
              : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: content,
          );
        },
      ),
    );
  }
}

// UI elements (padding, margins) ko screen ke hisaab se scale karne ke liye extension
extension ResponsiveSize on num {
  double get h => (this / 844) * Get.height; // 844 is standard design height
  double get w => (this / 390) * Get.width;  // 390 is standard design width
}