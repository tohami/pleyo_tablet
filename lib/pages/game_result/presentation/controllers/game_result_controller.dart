import 'package:get/get.dart';

class GameResultController extends SuperController<bool> {
  bool isChampion = Get.rootDelegate.parameters["game_mode"] == "true";

  String? points = Get.rootDelegate.parameters["points"];

  String? playerName = Get.rootDelegate.parameters["player_name"];

  String? score = Get.rootDelegate.parameters["score"];

  GameResultController();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    Future.delayed(const Duration(seconds: 10) , () {
      Get.rootDelegate.popRoute();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // ignore: avoid_print
    print('onClose called');
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    // ignore: avoid_print
    print('the window size did change');
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    // ignore: avoid_print
    print('platform change ThemeMode');
    super.didChangePlatformBrightness();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // ignore: avoid_print
    print('the route $route will be open');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    // ignore: avoid_print
    print('the current route will be closed');
    return super.didPopRoute();
  }

  @override
  void onDetached() {
    // ignore: avoid_print
    print('onDetached called');
  }

  @override
  void onInactive() {
    // ignore: avoid_print
    print('onInative called');
  }

  @override
  void onPaused() {
    // ignore: avoid_print
    print('onPaused called');
  }

  @override
  void onResumed() {
    // ignore: avoid_print
    print('onResumed called');
  }
}
