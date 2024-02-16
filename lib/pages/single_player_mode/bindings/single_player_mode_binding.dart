import 'package:get/get.dart';

import '../presentation/controllers/single_player_mode_controller.dart';

class SinglePlayerModeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SinglePlayerModeController());
  }
}
