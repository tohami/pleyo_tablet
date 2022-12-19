import 'package:firebase_auth/firebase_auth.dart';
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
  RxBool isLoading = false.obs ;
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
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  onStartClicked() async {
    if(isLoading.value == true)
      return ;
    try {
      isLoading.value = true ;
      var station = await splashRepository.getStationData();
      StationService.to.currentStation = station;
      Get.rootDelegate.offNamed(Routes.SCAN_QR);
    } catch (e) {
      print(e) ;
      showAlert("Error", "Unable to load station data", "Retry", ()=> onStartClicked()) ;
    }finally {
      isLoading.value = false ;
    }
  }
}
