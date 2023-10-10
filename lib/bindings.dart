import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/splash/data/splash_api_provider.dart';
import 'package:pleyo_tablet_app/pages/splash/data/splash_repository.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ISplashProvider>(()=> SplashProvider());
    Get.put<ISplashRepository>(SplashRepository(provider: Get.find()));
  }
}
