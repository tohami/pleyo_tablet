import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import "package:collection/collection.dart";
import 'package:pleyo_tablet_app/model/strapi/station.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

class SinglePlayerModeController extends SuperController<bool> {
  final playerNameController = TextEditingController();
  final autoGeneratedNumberController = TextEditingController();
  RxBool goPlaying = false.obs;

  RxBool isChampoinship = true.obs;

  Station station = StationService.to.currentStation;
  late Map<Game, List<GameVariant>> games = groupBy(
      station.attributes!.gameVariants!.data!,
      (GameVariant item) => item.attributes!.game!.data!);

  Rx<GameVariant?> selectedVariant = Rx(null);

  Rx<Game?> selectedGame = Rx(null);

  int? selectedGameDifficulty;
  RxBool gameFail = false.obs;


  @override
  void onInit() {
    super.onInit();
    playerNameController.addListener(() {
      if (playerNameController.text.isNotEmpty &&
          playerNameController.text.length >= 3) {
        goPlaying.value = true;
      } else {
        goPlaying.value = false;
      }
    });
    generatePIN();
  }

  void generatePIN() {
    int min = 1000;
    int max = 9000;
    var randomizer = new Random();
    var rNum = min + randomizer.nextInt(max - min);

    autoGeneratedNumberController.text = "#" + rNum.toString();
  }

  void changeMode(bool val) {
    isChampoinship.value = val;
  }
  void setSelectedGameDifficulty(int? selectedDifficulty) {
    selectedGameDifficulty = selectedDifficulty;
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
}
