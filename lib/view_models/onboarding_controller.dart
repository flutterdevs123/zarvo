
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../res/routes/app_routes.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  late PageController pageController;

  // Expanded Onboarding Content
  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "ROLE-BASED DYNAMIC DASHBOARD",
      "description": [
        "Personalized Dashboard for every user.",
        "Separate experience for Students, Housewives, and Businessmen.",
        "Smartly adapts widgets and tools according to daily needs.",
        "A personalized ecosystem that evolves with you.",
      ],
      "image": "assets/images/onboarding1.jpg",
    },
    {
      "title": "SMART MULTI-UTILITY ENGINE",
      "description": [
        "Advanced calculators for everyday calculations.",
        "Smart alarms and reminders.",
        "Live news tickers for quick updates.",
        "World time converters for different time zones.",
        "Multiple utilities in one seamless application.",
      ],
      "image": "assets/images/onboarding2.jpg",
    },
    {
      "title": "ZERO SERVER COST ARCHITECTURE",
      "description": [
        "Lightning-fast performance with local storage.",
        "No server dependency for core features.",
        "Fully secure and privacy-focused experience.",
        "Works offline without an internet connection.",
        "No cloud subscription costs.",
      ],
      "image": "assets/images/onboarding3.jpg",
    },
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // Update Current Page
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  // Move to Next Page or Dashboard
  void nextPage() {
    if (currentPage.value == onboardingData.length - 1) {
      Get.offAllNamed(AppRoutes.dashboard);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }
}
