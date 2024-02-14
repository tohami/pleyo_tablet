import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

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
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '10'.obs;
  final chooseGameDifficulty = true.obs;

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

  @override
  void onReady() {
    var counter = 20;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      counter--;
      if (counter == 0) {
        chooseGameDifficulty.value = false;
        print('Cancel timer');
        timer.cancel();
        _startTimer(10);
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        setSelectedGameDifficulty(selectedGame
            .attributes!.gameDifficulties!.data![0].attributes!.difficulty);
        Get.rootDelegate.toNamed(Routes.START_GAME);
      } else {
        int seconds = (remainingSeconds % 60);
        time.value = seconds.toString();
        remainingSeconds--;
      }
    });
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
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
