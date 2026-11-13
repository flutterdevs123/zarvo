import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ZarvoBackground extends StatefulWidget {
  final Widget child;

  const ZarvoBackground({super.key, required this.child});

  @override
  State<ZarvoBackground> createState() => _ZarvoBackgroundState();
}

class _ZarvoBackgroundState extends State<ZarvoBackground> with SingleTickerProviderStateMixin {
  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();
    // Background Breathing Glow Animation
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  Widget _buildAmbientBlob(Color color, double size) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Solid Base Color
        Container(color: AppColors.bgDark),

        // 2. Animated Ambient Blobs (Corner Glows)
        AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: -100, left: -50,
                    child: Transform.scale(
                      scale: 1.0 + (_bgController.value * 0.1),
                      child: _buildAmbientBlob(AppColors.accentPurple.withOpacity(0.15), 300),
                    ),
                  ),
                  Positioned(
                    bottom: -50, right: -50,
                    child: Transform.scale(
                      scale: 1.0 + (_bgController.value * 0.15),
                      child: _buildAmbientBlob(AppColors.primaryNeonBlue.withOpacity(0.15), 350),
                    ),
                  ),
                ],
              );
            }
        ),

        // 3. Foreground Screen Content
        widget.child,
      ],
    );
  }
}