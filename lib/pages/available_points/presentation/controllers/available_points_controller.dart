import 'package:get/get.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

import '../../../../model/strapi/ticket.dart';

class AvailablePointsController extends SuperController<dynamic> {

  Ticket ticket = StationService.to.currentTicket;

  AvailablePointsController();

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 6)).then((value) {
      Get.rootDelegate.offNamed(Routes.HOME);
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
