import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  // Observable variable to track current theme mode
  RxBool isDarkMode = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Yahan hum future mein local storage (shared_preferences/GetStorage)
    // se saved theme load karne ka code daal sakte hain.
  }

  // Theme toggle function
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;

    // GetX ko batayen ke theme change karni hai
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);

    // Yahan local storage mein true/false save karwane ka code bhi likh sakte hain baad mein
  }
}