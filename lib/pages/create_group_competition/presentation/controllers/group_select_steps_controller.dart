import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import "package:collection/collection.dart";
import 'package:pleyo_tablet_app/model/strapi/group_competition.dart' as gc;
import 'package:pleyo_tablet_app/model/strapi/organization.dart';
import 'package:pleyo_tablet_app/model/strapi/personas.dart';
import 'package:pleyo_tablet_app/model/strapi/station.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/alert.dart';
import '../../data/group_repository.dart';

class GroupPlayStepsController extends SuperController<bool> {
  final teamNameController = TextEditingController();
  final playerName1Controller = TextEditingController();
  final playerName2Controller = TextEditingController();
  final playerName3Controller = TextEditingController();
  final playerName4Controller = TextEditingController();
  final playerName5Controller = TextEditingController();
  RxBool goPlaying = false.obs;
  RxInt selectedPleyerNameIndex = (-1).obs;

  GroupTemplates? template = null;

  final templatePersonas = <Personas>[];
  final playersPersonas = <Personas>[];

  RxBool isChampoinship = true.obs;

  Station station = StationService.to.currentStation;
  late Map<Game, List<GameVariant>> games = groupBy(
      station.attributes!.gameVariants!.data!,
      (GameVariant item) => item.attributes!.game!.data!);

  Rx<GameVariant> selectedGameVariant = GameVariant().obs;
  Game? selectedGame = null;

  final IGroupsRepository repository;

  GroupPlayStepsController(this.repository);

  @override
  void onInit() {
    super.onInit();
    templatePersonas.clear();
    var personaRandomIndex = Random().nextInt(StationService.to.personasGroups.length) ;
    templatePersonas
        .addAll(StationService.to.personasGroups[personaRandomIndex].attributes!.personas!);

    teamNameController.addListener(() {
      if (teamNameController.text.isNotEmpty &&
          teamNameController.text.length >= 3) {
        goPlaying.value = true;
      } else {
        goPlaying.value = false;
      }
    });

    playerName1Controller.text = templatePersonas[0].nickname ?? "";

    playerName1Controller.addListener(() {
      if (playerName1Controller.text.isNotEmpty) {
        playersPersonas[0].nickname = playerName1Controller.text;
      } else {
        playersPersonas[0].nickname = templatePersonas[0].nickname;
      }
    });

    playerName2Controller.text = templatePersonas[1].nickname ?? "";
    playerName2Controller.addListener(() {
      if (playerName2Controller.text.isNotEmpty) {
        playersPersonas[1].nickname = playerName2Controller.text;
      } else {
        playersPersonas[1].nickname = templatePersonas[1].nickname;
      }
    });

    playerName3Controller.text = templatePersonas[2].nickname ?? "";
    playerName3Controller.addListener(() {
      if (playerName3Controller.text.isNotEmpty) {
        playersPersonas[2].nickname = playerName3Controller.text;
      } else {
        playersPersonas[2].nickname = templatePersonas[2].nickname;
      }
    });

    playerName4Controller.text = templatePersonas[3].nickname ?? "";
    playerName4Controller.addListener(() {
      if (playerName4Controller.text.isNotEmpty) {
        playersPersonas[3].nickname = playerName4Controller.text;
      } else {
        playersPersonas[3].nickname = templatePersonas[3].nickname;
      }
    });

    playerName5Controller.text = templatePersonas[4].nickname ?? "";
    playerName5Controller.addListener(() {
      if (playerName5Controller.text.isNotEmpty) {
        playersPersonas[4].nickname = playerName5Controller.text;
      } else {
        playersPersonas[4].nickname = templatePersonas[4].nickname;
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

  void updateTemplate(GroupTemplates e) {
    template = e;
    playersPersonas.clear();

    playersPersonas.addAll(templatePersonas.sublist(0, e.numberOfPlayers));
  }

  RxBool createGroupLoading = false.obs ;

  void createGroupCompetition() async{
    try {
      createGroupLoading.value = true;
      var result = await repository.createGroupCompetition(gc.GroupCompetition(
          playersCount: template!.numberOfPlayers,
          playerCredit: template!.numberOfTurns,
          startWithFirstGame: true,
          duration: 60 * 24,
          name: teamNameController.text,
          tickets: playersPersonas
              .mapIndexed((i, e) =>
              gc.Ticket(
                  avatar: e.avatar,
                  nickname: e.nickname,
                  playOrder: i,
                  credit: template!.numberOfTurns,
                  isEnabled: true,
                  isActivated: true))
              .toList(),
          gameVariant: GameVariant(id: selectedGameVariant.value.id),
          games: [gc.Game(id: selectedGame?.id)],
          type: "group",
          isStarted: false,
          isEnabled: true,
          isEnded: false,
          organization: StationService.to.currentStation.attributes
              ?.organization?.data?.id,
          stations: [StationService.to.currentStation.id!]));
      Get.rootDelegate.toNamed(
        Routes.GROUP_TURN_LANDING,
        arguments: result,
      );
    }catch (e) {
      showAlert("Error", "Connection error");
    } finally {
      createGroupLoading.value = false;
    }
  }
}
