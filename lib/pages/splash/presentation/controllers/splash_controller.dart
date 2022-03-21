import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../data/splash_repository.dart';

class SplashController extends SuperController<dynamic> {
  SplashController({required this.splashRepository});

  final ISplashRepository splashRepository;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      var isLoggedIn = FirebaseAuth.instance.currentUser != null;
      if (isLoggedIn) {
        Get.rootDelegate.offNamed(Routes.HOME);
      } else {
        Get.rootDelegate.offNamed(Routes.LOGIN);
      }
    });
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
