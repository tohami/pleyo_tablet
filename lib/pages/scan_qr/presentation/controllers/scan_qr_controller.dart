import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/data/tickets_repository.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/widgets/alert.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../../../../routes/app_pages.dart';

class TicketController extends SuperController<bool>
    with GetSingleTickerProviderStateMixin {
  late AnimationController _boxAnimationController;
  late Animation<double> boxAnimation;
  final isQrScan = true.obs ;


  TicketController({required this.repository});

  final ITicketRepository repository;

  QRViewController? controller;

  final RxString inputCode = "".obs;
  RxBool isScanned = false.obs;
  RxBool isLoading = false.obs ;
  RxString errorMsg = "".obs ;
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() async {
    ScreenBrightness().setScreenBrightness(1);
    super.onInit();
    _boxAnimationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    boxAnimation = Tween<double>(
      begin: 1,
      end: 1.10,
    ).animate(
      CurvedAnimation(
        parent: _boxAnimationController,
        curve: Curves.ease,
      ),
    );
    try {
      _boxAnimationController.repeat(reverse: true).orCancel;
    } on TickerCanceled catch (e) {}
    change(null, status: RxStatus.success());
  }

  Future checkTicketWithPinCode(String code) async{
    if(isLoading.value)
      return ;

    errorMsg.value = "" ;
    try {
      isLoading.value = true ;
      var ticket = await repository.checkTicket(code, "");
      StationService.to.currentTicket = ticket ;
      if (ticket.attributes?.isActivated == true) {
        Get.rootDelegate.offNamed(Routes.HOME);
        FirebaseCrashlytics.instance.setUserIdentifier(ticket.id.toString()) ;
      } else {
        print("ticket ticket" + ticket.id.toString()) ;
        Get.rootDelegate.offNamed(Routes.ACTIVATE , arguments: ticket);
      }
    } catch (e) {
      print(e) ;
      if(e is MapEntry){
        errorMsg.value = e.value ;
      }else {
        errorMsg.value = "Invalid ticket" ;
      }
      FirebaseCrashlytics.instance.log("Get ticket Error") ;
      FirebaseCrashlytics.instance.recordError(
          e,
          null,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true
      );
    } finally {
      inputCode.value = "" ;
      isLoading.value = false ;
    }
  }

  Future onTicketScanned(String url) async {
    try {
      errorMsg.value = "" ;
      controller?.pauseCamera() ;
      var data = url.split("/") ;
      if(data.length != 6) {
        var result = await showAlert("Error", "Invalid QrCode") ;
        controller?.resumeCamera() ;
        return ;
      }
      var codeText = data[4].padLeft(8 , "0");
      inputCode.value = codeText.substring(0, 4) + "-" + codeText.substring(4, 8);

      var ticket = await repository.checkTicket(data[4], data[5]);
      StationService.to.currentTicket = ticket ;
      if (ticket.attributes?.isActivated == true) {
        Get.rootDelegate.offNamed(Routes.HOME);
        FirebaseCrashlytics.instance.setUserIdentifier(ticket.id.toString()) ;
      } else {
        print("ticket ticket" + ticket.id.toString()) ;
        Get.rootDelegate.offNamed(Routes.ACTIVATE , arguments: ticket);
      }
    } catch (e) {
      inputCode.value = "" ;
      if(e is MapEntry){
        errorMsg.value = e.value ;
      }else {
        errorMsg.value = "Invalid ticket" ;
      }
      controller?.resumeCamera() ;
      FirebaseCrashlytics.instance.log("Get ticket Error") ;
      FirebaseCrashlytics.instance.recordError(
          e,
          null,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    ScreenBrightness().resetScreenBrightness();
    // ignore: avoid_print
    print('onClose called');
    controller?.dispose();
    _boxAnimationController.dispose();
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

  void onQRViewCreated(QRViewController controller) async {
    if (kDebugMode) {
      await onTicketScanned(
          "https://pleyo-operator-frontend.vercel.app/activate/20873/0f2c19f3-9c0b-4805-9c48-b83950ee5f66");
      return;
    }

    this.controller = controller;
    controller.resumeCamera();

    CameraFacing cameraInfo = await controller.getCameraInfo();
    if (!kDebugMode && cameraInfo == CameraFacing.back) {
      await controller.flipCamera();
    }

    var loading = false;
    controller.scannedDataStream.listen((scanData) async {
      if (loading) {
        return;
      }
      loading = true;
      isScanned.value = true;
      final data = scanData.code;
      await onTicketScanned(data!);
      loading = false;
      isScanned.value = false;
    });
  }
}
