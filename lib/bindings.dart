import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/data/multiplayer_api_provider.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/data/multiplayer_repository.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/controllers/multiplayer_guest_controller.dart';
import 'package:pleyo_tablet_app/pages/splash/data/splash_api_provider.dart';
import 'package:pleyo_tablet_app/pages/splash/data/splash_repository.dart';

import 'services/station_service.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ISplashProvider>(()=> SplashProvider());
    Get.put<ISplashRepository>(SplashRepository(provider: Get.find()));
    Get.put(StationService());

    Get.lazyPut<IMultiplayerProvider>(() => MultiplayerProvider());
    Get.lazyPut<IMultiplayerRepository>(() => MultiplayerRepository(provider: Get.find()));
    Get.put(MultiplayerGuestController(multiplayerRepository: Get.find()));

  }
}
