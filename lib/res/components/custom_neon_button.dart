import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomNeonButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onTap;
  final double width;
  final double height;

  const CustomNeonButton({
    super.key,
    this.text,
    this.icon,
    required this.onTap,
    this.width = 150,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryNeonBlue, AppColors.accentPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(height / 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryNeonBlue.withOpacity(0.4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: text != null
            ? Text(
          text!,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        )
            : Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}