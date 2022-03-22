import 'package:get/get.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

class AvailablePointsController extends SuperController<dynamic> {
  AvailablePointsController();

  num points = 000;
  @override
  void onInit() {
    super.onInit();
    if (points < 200) points++;

    // Future.delayed(const Duration(seconds: 6)).then((value) {
    //   Get.rootDelegate.offNamed(Routes.HOME);
    // });
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
