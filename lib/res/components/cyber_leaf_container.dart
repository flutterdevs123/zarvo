import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CyberLeafContainer extends StatelessWidget {
  final Widget? child;
  final double height;
  final double width;
  final String? imageUrl;

  const CyberLeafContainer({
    super.key,
    this.child,
    this.height = 320,
    this.width = double.infinity,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(70),
          bottomRight: Radius.circular(70),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        border: Border.all(color: AppColors.primaryNeonBlue.withOpacity(0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryNeonBlue.withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(68),
          bottomRight: Radius.circular(68),
          topRight: Radius.circular(13),
          bottomLeft: Radius.circular(13),
        ),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.asset(
          imageUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.rocket_launch_rounded, size: 80, color: AppColors.primaryNeonBlue),
          ),
        )
            : child,
      ),
    );
  }
}