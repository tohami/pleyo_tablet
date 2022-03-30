import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/qrcode_model.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

class AvailablePointsController extends SuperController<dynamic> {

  QrCodeModel qrCodeModel = Get.rootDelegate.arguments() ;

  AvailablePointsController();

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 6)).then((value) {
      Get.rootDelegate.offNamed(Routes.HOME , arguments: qrCodeModel);
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
