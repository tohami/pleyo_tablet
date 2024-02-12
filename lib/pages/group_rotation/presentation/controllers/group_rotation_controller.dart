import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';

class GroupRotationController extends SuperController<bool> {
  GameVariant selectedGame = Get.rootDelegate.arguments();
  final groupEmailController = TextEditingController();
  String playerName = 'Rossana';
  int playersNumber = 5;
  int gameAttemptNumbers = 2;
  int? selectedGameDifficulty;
  RxBool gameFail = false.obs;
  RxBool isEmailEnabled = false.obs;
  RxBool isEmailValid = false.obs;
  RxBool isEmailAdded = false.obs;


  @override
  void onInit() {
    super.onInit();
    groupEmailController.addListener(() {
      if (groupEmailController.text.isNotEmpty &&
          isValidEmail(groupEmailController.text)) {
        isEmailValid.value = true;
      } else {
        isEmailValid.value = false;
      }
    });
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  void setSelectedGameDifficulty(int? selectedDifficulty) {
    selectedGameDifficulty = selectedDifficulty;
  }
}
