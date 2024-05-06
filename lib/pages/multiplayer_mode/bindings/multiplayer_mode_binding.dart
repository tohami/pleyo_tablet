import 'package:get/get.dart';

import '../../home/data/games_api_provider.dart';
import '../../home/data/games_repository.dart';
import '../data/multiplayer_api_provider.dart';
import '../data/multiplayer_repository.dart';
import '../presentation/controllers/multiplayer_host_controller.dart';

class MultiplayerModeBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<IMultiplayerProvider>(() => MultiplayerProvider());
    // Get.lazyPut<IMultiplayerRepository>(() => MultiplayerRepository(provider: Get.find()));

    Get.lazyPut(() => MultiplayerHostController(multiplayerRepository: Get.find()));
  }
}
