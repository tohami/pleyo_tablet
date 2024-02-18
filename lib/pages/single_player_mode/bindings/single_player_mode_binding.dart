import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/data/single_play_api_provider.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/data/single_play_repository.dart';

import '../../home/data/games_api_provider.dart';
import '../../home/data/games_repository.dart';
import '../presentation/controllers/single_player_mode_controller.dart';

class SinglePlayerModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ISinglePlayProvider>(() => SinglePlayProvider());
    Get.lazyPut<ISinglePlayRepository>(() => SinglePlayRepository(provider: Get.find()));

    Get.lazyPut<IGamesProvider>(() => GamesProvider());
    Get.lazyPut<IGamesRepository>(
            () => GamesRepository(provider: Get.find()));

    Get.lazyPut(() => SinglePlayerModeController(singlePlayRepository: Get.find() , gamesRepository: Get.find()));
  }
}
