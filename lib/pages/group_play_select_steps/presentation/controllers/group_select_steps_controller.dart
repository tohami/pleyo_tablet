import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupPlayStepsController extends SuperController<bool> {
  final teamNameController = TextEditingController();
  RxBool goPlaying = false.obs;

  GroupPlayStepsController();

  @override
  void onInit() {
    super.onInit();
    teamNameController.addListener(() {
      if (teamNameController.text.isNotEmpty &&
          teamNameController.text.length >= 3) {
        goPlaying.value = true;
      } else {
        goPlaying.value = false;
      }
    });
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

  void validateTeamName(String value) {}
}
