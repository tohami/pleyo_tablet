import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/qrcode_model.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

import '../../data/activate_repository.dart';

class ActivateController extends SuperController<dynamic> with GetSingleTickerProviderStateMixin {

  late AnimationController _buttonAnimationController;
  RxBool isButtonTapDown = false.obs ;
  late Animation<double> buttonAnimation;

  TextEditingController nickNameController = TextEditingController();

  Ticket ticket = Get.rootDelegate.arguments() ;

  final IActivateRepository repository ;


  ActivateController({required this.repository});

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

  onStartClicked() async{
    try {
      final nickname = nickNameController.text ;

      var newTicket = await repository.activateTicket(ticket.id! , ticket.attributes!.secret! , nickname);
      if (newTicket.attributes?.isActivated == true) {
        Get.rootDelegate.offNamed(Routes.HOME, arguments: ticket);
      } else {
        Get.snackbar("Error", "Failed to activate ticket ");
      }
    } catch (e) {
      printError(info: e.toString()) ;
      Get.snackbar("Error", e.toString());
    }
  }
}
