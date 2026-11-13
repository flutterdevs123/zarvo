import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

// Screens
import '../../view/splash_screen.dart';
import '../../view/onboarding_screen.dart';

// Controllers
import '../../view_models/splash_controller.dart';
import '../../view_models/onboarding_controller.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() {
        Get.put(OnboardingController());
      }),
      transition: Transition.fadeIn, // Splash se nikalte waqt smooth fade transition
    ),

    // Placeholder for Dashboard
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const Scaffold(
        body: Center(child: Text("Welcome to Dashboard", style: TextStyle(fontSize: 24))),
      ),
    ),
  ];
}