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
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  onStartClicked() {
    Get.rootDelegate.offNamed(Routes.HOME);
  }
}
