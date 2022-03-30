import 'package:get/get.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

class GameStatusController extends SuperController<bool> {
  GameStatusController();

  bool isChampion = Get.rootDelegate.parameters["game_mode"] == "true";

  String? points = Get.rootDelegate.parameters["points"];

  String? playerName = Get.rootDelegate.parameters["player_name"];

  @override
  void onInit() {
    super.onInit();
    // change(null, status: RxStatus.success());

    Future.delayed(const Duration(seconds: 2)).then((value) {
      Get.rootDelegate.toNamed(Routes.GAME_RESULT, parameters: {
        "game_mode": isChampion.toString(),
        "points": points ?? "",
        "player_name": playerName ?? ""
      });
    });
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
