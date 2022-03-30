import 'package:get/get.dart';

class GameStatusController extends SuperController<bool> {
  GameStatusController();

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
