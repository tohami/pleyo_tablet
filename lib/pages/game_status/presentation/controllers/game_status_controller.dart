import 'package:get/get.dart';

class GameStatusController extends SuperController<bool> {
  GameStatusController();

  bool isChampion = Get.rootDelegate.parameters["game_mode"] == "true";

  String? points = Get.rootDelegate.parameters["points"] != "0"
      ? Get.rootDelegate.parameters["points"]
      : "10";

  String? playerName = Get.rootDelegate.parameters["player_name"] != ""
      ? Get.rootDelegate.parameters["player_name"]
      : "Test";

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
