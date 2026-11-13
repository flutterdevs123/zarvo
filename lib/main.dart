import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Imports (Inke paths apne folders ke hisaab se adjust kar lijiyega)
import 'res/constants/app_info.dart';
import 'res/theme/app_theme.dart';
import 'res/routes/app_routes.dart';
import '../../res/routes/app_pages.dart';
import 'view_models/theme_controller.dart';

void main() {
  // Flutter bindings initialize karna zaroori hai
  WidgetsFlutterBinding.ensureInitialized();

  // Theme Controller ko app start hotay hi memory me inject kar diya
  Get.put(ThemeController());

  runApp(const ZarvoApp());
}

class ZarvoApp extends StatelessWidget {
  const ZarvoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ThemeController ka instance get kar rahe hain
    final themeController = Get.find<ThemeController>();

    // Obx widget GetX ka reactive state manager hai,
    // jab theme change hogi, yeh app ko rebuild karega.
    return Obx(() {
      return GetMaterialApp(
        title: AppInfo.appName,
        debugShowCheckedModeBanner: false,

        // Theme Setup
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,

        // Routing Setup
        initialRoute: AppRoutes.splash, // Abhi splash se start hoga
        getPages: AppPages.pages,

        // Agar aapki initialRoute set nahi hai to temporary home page:
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Yahan aap apna logo show kar sakte hain
                Image.asset(
                  AppInfo.appLogo,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Welcome to ${AppInfo.appName}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}