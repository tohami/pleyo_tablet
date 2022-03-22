import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../../routes/app_pages.dart';

class ScanQRController extends SuperController<bool> {
  ScanQRController();

  Barcode? result;
  QRViewController? controller;
  RxBool isValid = false.obs;
  RxString qrCode = "".obs;

  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // ignore: avoid_print
    print('onClose called');
    controller?.dispose();
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

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.stopCamera();
      qrCode.value = scanData.code ?? "";
      Future.delayed(const Duration(seconds: 3)).then((value) {
        if (qrCode.value.isNotEmpty) {
          Get.rootDelegate.offNamed(Routes.AVAILABLE_POINTS);
        } else {
          Get.rootDelegate.offNamed(Routes.SPLASH);
        }
      });
    });
  }
}
