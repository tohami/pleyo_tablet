import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/qrcode_model.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../../routes/app_pages.dart';

class ScanQRController extends SuperController<bool> with GetSingleTickerProviderStateMixin{
  late AnimationController _boxAnimationController;
  late Animation<double> boxAnimation;

  ScanQRController();
  QRViewController? controller;
  RxBool isScanned = false.obs ;
  TextEditingController emailController = TextEditingController();

  @override
  void onInit() {
    super.onInit() ;
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
      _boxAnimationController
          .repeat(reverse: true)
          .orCancel;
    }on TickerCanceled catch (e) {

    }
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
    _boxAnimationController.dispose() ;
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

  DatabaseReference qrCodeRef = FirebaseDatabase.instance.ref("QRCode");


  void onQRViewCreated(QRViewController controller) async{
    this.controller = controller;

    var qrCodeEntity = await qrCodeRef.child("-MzQWdLFUQnEYYNlmrV4").get();
    var qrCode = QrCodeModel.fromJson(qrCodeEntity.value as Map<dynamic, dynamic>) ;
    if(qrCode.remainingCredit! > 0) {
      isScanned.value = true ;
      await Future.delayed(const Duration(seconds: 2)) ;
      Get.rootDelegate.offNamed(Routes.AVAILABLE_POINTS , arguments: qrCode);
    }else {
      Get.snackbar("Error", "You don't have any Credit left in your card");
    }
    CameraFacing cameraInfo = await controller.getCameraInfo();
    if(cameraInfo == CameraFacing.back){
      await controller.flipCamera();
    }
    controller.scannedDataStream.listen((scanData)async {
      controller.stopCamera();
      try {
        var qrCodeEntity = await qrCodeRef.child(scanData.code!).get();
        var qrCode = QrCodeModel.fromJson(qrCodeEntity.value as Map<dynamic, dynamic>) ;
        if(qrCode.remainingCredit! > 0) {
          isScanned.value = true ;
          await Future.delayed(const Duration(seconds: 2)) ;
          Get.rootDelegate.offNamed(Routes.AVAILABLE_POINTS , arguments: qrCode);
        }else {
          Get.snackbar("Error", "You don't have any Credit left in your card");
        }
      }catch (e) {
        Get.snackbar("Error", "Invalid Qr code");
        print(e) ;
      } finally {
        controller.resumeCamera() ;
        isScanned.value = false ;
      }
    });
  }
}
