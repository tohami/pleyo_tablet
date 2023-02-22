import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/widgets/alert.dart';

import '../../data/activate_repository.dart';

class ActivateController extends SuperController<dynamic> with GetSingleTickerProviderStateMixin {

  late AnimationController _buttonAnimationController;
  RxBool isButtonTapDown = false.obs ;
  late Animation<double> buttonAnimation;

  TextEditingController nickNameController = TextEditingController();

  Ticket ticket = Get.rootDelegate.arguments() ;

  final IActivateRepository repository ;

  RxMap<String , String> activationFormValue = RxMap();


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
  void onClose() {
    // ignore: avoid_print
    print('onClose called');
    _buttonAnimationController.dispose();
    super.onClose();
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
      //validate form

      final nickname = nickNameController.text ;
      bool validForm = true ;
      ticket.attributes?.competition?.activationScreen?.fields?.forEach((element) {
        if(element.required == true && activationFormValue[element.key!]?.isBlank != false){
          validForm = false ;
        }
      });
      if(nickname.length < 2 || !validForm){
        return ;
      }
      var newTicket = await repository.activateTicket(ticket.id! , ticket.attributes!.secret! , nickname , activationFormValue.value);
      if (newTicket.attributes?.isActivated == true) {
        StationService.to.currentTicket = newTicket ;
        Get.rootDelegate.offNamed(Routes.HOME, arguments: ticket);
      } else {

        showAlert("Error", "Failed to activate ticket ");
      }
    } catch (e) {
      printError(info: e.toString()) ;
      if(e is MapEntry){
        var result = await showAlert(e.key, e.value) ;
      }else {
        var result = await showAlert("Error", "Unable to activate the ticket, try again") ;
      }
    }
  }
}
