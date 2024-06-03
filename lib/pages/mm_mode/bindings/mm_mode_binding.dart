import 'package:get/get.dart';

import '../presentation/controllers/mm_controller.dart';


class MMModeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<IMultiplayerProvider>(() => MultiplayerProvider());
    // Get.lazyPut<IMultiplayerRepository>(() => MultiplayerRepository(provider: Get.find()));

    Get.lazyPut(() => MMController(multiplayerRepository: Get.find()));
  }
}
