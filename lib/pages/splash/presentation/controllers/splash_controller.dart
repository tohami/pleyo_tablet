import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/widgets/alert.dart';

import '../../../../routes/app_pages.dart';
import '../../data/splash_repository.dart';

class SplashController extends SuperController<dynamic> with GetSingleTickerProviderStateMixin{

  late AnimationController _buttonAnimationController;
  RxBool isButtonTapDown = false.obs ;
  late Animation<double> buttonAnimation;
  SplashController({required this.splashRepository});

  final ISplashRepository splashRepository;

  @override
  void onClose() {
    _buttonAnimationController.dispose() ;
    super.onClose();
  }
  @override
  void onInit() {
    super.onInit();

    _buttonAnimationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    buttonAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeIn,
      ),
    );
    try {
      _buttonAnimationController
          .repeat(reverse: true)
          .orCancel;
    }on TickerCanceled catch (e) {

    }

    StationService.to.isReady.listenAndPump((event) {
      if(event){
        var currentStation = StationService.to.currentStation.attributes ;
        if(currentStation?.massiveMultiplayerEnabled == true){
          Get.rootDelegate.offNamed(Routes.MM);
        }else if(currentStation?.singlePlayerEnabled == true || currentStation?.multiplayerEnabled == true || currentStation?.groupEnabled == true) {
          Get.rootDelegate.offNamed(Routes.MODE);
        }else {
          Get.rootDelegate.offNamed(Routes.SCAN_QR);
        }
      }
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

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

}
