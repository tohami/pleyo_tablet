import 'package:get/get.dart';
import '../data/splash_api_provider.dart';

import '../data/splash_repository.dart';
import '../presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ISplashProvider>(SplashProvider());
    Get.put<ISplashRepository>(SplashRepository(provider: Get.find()));
    Get.put(SplashController(splashRepository: Get.find()));
  }
}
