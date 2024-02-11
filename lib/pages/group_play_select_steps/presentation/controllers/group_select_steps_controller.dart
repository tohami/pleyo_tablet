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
    playerName1Controller.text="Rosana";
    playerName1Controller.addListener(() {
      if (playerName1Controller.text.isNotEmpty) {
        players[0]=playerName1Controller.text;
      } else {
        players[0]="Rosana";
      }
    });
    playerName2Controller.text="Spike";
    playerName2Controller.addListener(() {
      if (playerName2Controller.text.isNotEmpty) {
        players[1]=playerName2Controller.text;
      } else {
        players[1]="Spike";
      }
    });
    playerName3Controller.text="Bahhnaa";
    playerName3Controller.addListener(() {
      if (playerName3Controller.text.isNotEmpty) {
        players[2]=playerName3Controller.text;
      } else {
        players[2]="Bahhnaa";
      }
    });
    playerName4Controller.text="One";
    playerName4Controller.addListener(() {
      if (playerName4Controller.text.isNotEmpty) {
        players[3]=playerName4Controller.text;
      } else {
        players[3]="One";
      }
    });
    playerName5Controller.text="Erith";
    playerName5Controller.addListener(() {
      if (playerName5Controller.text.isNotEmpty) {
        players[4]=playerName5Controller.text;
      } else {
        players[4]="sErith";
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
