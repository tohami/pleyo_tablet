import 'package:get/get.dart';

import '../presentation/controllers/game_result_controller.dart';

class GameResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameResultController());
  }
}
