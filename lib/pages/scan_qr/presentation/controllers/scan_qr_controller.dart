import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/pages/scan_qr/data/tickets_repository.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../../routes/app_pages.dart';

class TicketController extends SuperController<bool>
    with GetSingleTickerProviderStateMixin {
  late AnimationController _boxAnimationController;
  late Animation<double> boxAnimation;

  TicketController({required this.repository});

  final ITicketRepository repository;

  QRViewController? controller;
  RxBool isScanned = false.obs;

  TextEditingController emailController = TextEditingController();

  @override
  void onInit() async {
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

    if (kDebugMode) {
      onTicketScanned(
          "https://pleyo-operator-frontend.vercel.app/activate/372/6bc65586-e03d-4eaa-bb82-9c9e875c9069");
    }
  }

  Future onTicketScanned(String url) async {
    try {
      var data = url.split("/") ;
      if(data.length != 6) {
        Get.snackbar("Error", "Invalid ticket");
        return ;
      }
      var ticket = await repository.checkTicket(int.parse(data[4]), data[5]);
      StationService.to.currentTicket = ticket ;
      if (ticket.attributes?.isActivated == true) {
        Get.rootDelegate.offNamed(Routes.HOME);
      } else {
        print("ticket ticket" + ticket.id.toString()) ;
        Get.rootDelegate.offNamed(Routes.ACTIVATE);
        Get.snackbar("Error", "Qr code is not active ");
      }
    } catch (e) {
      printError(info: e.toString()) ;
      Get.snackbar("Error", e.toString());
    }
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
          "https://pleyo-operator-frontend.vercel.app/activate/6bc65586-e03d-4eaa-bb82-9c9e875c9069");
      return;
    }

    this.controller = controller;
    controller.resumeCamera();

    CameraFacing cameraInfo = await controller.getCameraInfo();
    if (cameraInfo == CameraFacing.back) {
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
