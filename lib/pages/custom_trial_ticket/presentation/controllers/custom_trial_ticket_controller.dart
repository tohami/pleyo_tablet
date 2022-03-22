import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class CustomTrialTicketController extends SuperController<bool> {
  CustomTrialTicketController();

  RxBool isValidAmount = false.obs;
  double points = 0.0;

  bool isTrial = Get.rootDelegate.parameters["is_trial"] == "1";

  TextEditingController amountController = TextEditingController();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    amountController.addListener(() {
      isValidAmount.value = amountController.text.isNotEmpty;
      update();
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

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.rootDelegate.offNamed(Routes.SPLASH);
  }

  void onContinueClicked() {
    Get.rootDelegate.offNamed(Routes.SCAN_QR);
  }
}
