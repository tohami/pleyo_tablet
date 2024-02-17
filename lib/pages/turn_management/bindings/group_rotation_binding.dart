import 'package:get/get.dart';

import '../../home/data/games_api_provider.dart';
import '../../home/data/games_repository.dart';
import '../presentation/controllers/group_rotation_controller.dart';

class GroupRotationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGamesProvider>(() => GamesProvider());
    Get.lazyPut<IGamesRepository>(
            () => GamesRepository(provider: Get.find()));

    Get.lazyPut(() => GroupRotationController(gamesRepository: Get.find()));
  }
}
