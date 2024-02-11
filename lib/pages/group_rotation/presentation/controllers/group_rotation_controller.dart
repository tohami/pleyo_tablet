import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';

class GroupRotationController extends SuperController<bool> {
  GameVariant selectedGame = Get.rootDelegate.arguments();
  int gameAttemptNumbers = 2;

  @override
  void onInit() {
    super.onInit();
    print(selectedGame.toJson());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }
}
