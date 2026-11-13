import 'package:get/get.dart';
import '../res/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigateToNext();
  }

  void _navigateToNext() async {
    // Splash screen ki entrance + loading sequences ke mutabiq total 4.5 seconds
    await Future.delayed(const Duration(milliseconds: 4500));

    // Yahan hum pehle dashboard bhej rahe thay, ab Onboarding par bhejenge
    Get.offAllNamed(AppRoutes.onboarding);
  }
}