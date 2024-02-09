import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import "package:collection/collection.dart";
import 'package:pleyo_tablet_app/model/strapi/station.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

class GroupPlayStepsController extends SuperController<bool> {
  final teamNameController = TextEditingController();
  final playerName1Controller = TextEditingController();
  final playerName2Controller = TextEditingController();
  final playerName3Controller = TextEditingController();
  final playerName4Controller = TextEditingController();
  final playerName5Controller = TextEditingController();
  RxBool goPlaying = false.obs;
  RxInt selectedItem = (-1).obs;
  int teamSize = 0;
  final players = <String>[];
  RxBool isChampoinship = true.obs;

  Station station = StationService.to.currentStation;
  late Map<Game, List<GameVariant>> games = groupBy(
      station.attributes!.gameVariants!.data!,
      (GameVariant item) => item.attributes!.game!.data!);

  Rx<GameVariant> selectedGame = GameVariant().obs;

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

  void changeMode(bool val) {
    isChampoinship.value = val;
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

  void updateTeamSize(int size) {
    teamSize = size;
    players.clear();
    players.addAll(List.generate(teamSize, (index) => ""));
  }
}
