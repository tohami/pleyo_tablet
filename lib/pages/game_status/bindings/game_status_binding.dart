import 'package:get/get.dart';

import '../../home/data/games_api_provider.dart';
import '../../home/data/games_repository.dart';
import '../presentation/controllers/game_status_controller.dart';

class GameStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGamesProvider>(() => GamesProvider());
    Get.lazyPut<IGamesRepository>(
            () => GamesRepository(provider: Get.find()));
    Get.lazyPut(() => GameStatusController(repository: Get.find()));
  }
}
