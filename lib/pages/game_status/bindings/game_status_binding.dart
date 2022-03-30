import 'package:get/get.dart';

import '../presentation/controllers/game_status_controller.dart';

class GameStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameStatusController());
  }
}
