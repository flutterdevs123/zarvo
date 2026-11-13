import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/theme/app_colors.dart';
import '../../res/utils/responsive_wrapper.dart';
import '../../res/components/cyber_leaf_container.dart';
import '../../res/components/custom_neon_button.dart';
import '../../res/components/glass_card.dart';
import '../../res/components/zarvo_background.dart'; // Naya component import
import '../../view_models/onboarding_controller.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    // Image pop & glow animation controller
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      // Pura content ab ZarvoBackground me wrap ho gaya hai
      body: ZarvoBackground(
        child: ResponsiveWrapper(
          disableScroll: true,
          child: Column(
            children: [
              const Spacer(flex: 1),

              // PageView
              Expanded(
                flex: 12,
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = controller.onboardingData[index];

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),

                            // 1. Entry Bounce Animation for Image
                            AnimatedBuilder(
                                animation: _pulseController,
                                builder: (context, child) {
                                  return TweenAnimationBuilder<double>(
                                    key: ValueKey('image_$index'),
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    duration: const Duration(milliseconds: 900),
                                    curve: Curves.elasticOut,
                                    builder: (context, value, child) {
                                      return Transform.scale(
                                        scale: 0.8 + (0.2 * value),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(60),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.primaryNeonBlue.withOpacity(0.1 + (_pulseController.value * 0.3)),
                                                blurRadius: 20 + (_pulseController.value * 30),
                                                spreadRadius: 2 + (_pulseController.value * 8),
                                              ),
                                            ],
                                          ),
                                          child: Opacity(
                                            opacity: value.clamp(0.0, 1.0),
                                            child: child,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CyberLeafContainer(height: 280, imageUrl: data["image"]),
                                  );
                                }
                            ),

                            const SizedBox(height: 40),

                            // 2. Glass Card Entry Animation with Gradient Text
                            TweenAnimationBuilder<double>(
                              key: ValueKey('text_$index'),
                              tween: Tween(begin: 0.0, end: 1.0),
                              duration: const Duration(milliseconds: 700),
                              curve: Curves.easeOutCubic,
                              builder: (context, value, child) {
                                return Transform.translate(
                                  offset: Offset(0, 40 * (1 - value)),
                                  child: Opacity(
                                    opacity: value.clamp(0.0, 1.0),
                                    child: child,
                                  ),
                                );
                              },
                              child: GlassCard(
                                child: Column(
                                  children: [
                                    ShaderMask(
                                      shaderCallback: (bounds) => const LinearGradient(
                                        colors: [AppColors.primaryNeonBlue, AppColors.accentPurple, AppColors.highlightGold],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ).createShader(bounds),
                                      child: Text(
                                        data["title"] ?? '',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20, // Adjusted font size for expanded content
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 1.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      data["description"] ?? '',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textGrey,
                                        height: 1.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bottom Navigation & Indicators
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dot Indicators
                    Obx(
                          () => Row(
                        children: List.generate(
                          controller.onboardingData.length,
                              (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 8),
                            height: 6,
                            width: controller.currentPage.value == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color: controller.currentPage.value == index
                                  ? AppColors.primaryNeonBlue
                                  : AppColors.textGrey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: controller.currentPage.value == index
                                  ? [const BoxShadow(color: AppColors.primaryNeonBlue, blurRadius: 10)]
                                  : [],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Custom Neon Button
                    Obx(() {
                      bool isLastPage = controller.currentPage.value == controller.onboardingData.length - 1;
                      return CustomNeonButton(
                        width: isLastPage ? 160 : 60,
                        text: isLastPage ? "GET STARTED" : null,
                        icon: isLastPage ? null : Icons.arrow_forward_ios_rounded,
                        onTap: controller.nextPage,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}