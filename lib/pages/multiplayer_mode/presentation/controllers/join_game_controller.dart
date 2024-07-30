import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/join_multiplayer_game_message.dart';
import 'package:pleyo_tablet_app/services/InactivityRedirectService.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';

import '../../../../routes/app_pages.dart';
import '../../data/multiplayer_repository.dart';

class JoinGameController extends SuperController<bool> {
  final playerNameController = TextEditingController();
  final autoGeneratedNumberController = TextEditingController();
  late JoinMultiplayerGameDetails gameDetails ;
  RxBool goPlaying = false.obs;

  final IMultiplayerRepository multiplayerRepository;


  JoinGameController(
      {required this.multiplayerRepository});

  @override
  void onInit() {
    super.onInit();
    playerNameController.addListener(() {
      Get.find<InactivityRedirectService>().userInteracted() ;
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
    int max = 9999;
    var randomizer = new Random();
    var rNum = min + randomizer.nextInt(max - min);

    autoGeneratedNumberController.text = "#" + rNum.toString();
  }

  Timer? retryTimer ;

  RxBool createTicketLoading = false.obs;

  void onPlayerNameSelected() async {
    if (playerNameController.text.length < 4) return;
    var joinMultiplayerGameData = await multiplayerRepository.joinMultiplayerGame(
        station: StationService.to.currentStation.id!,
        organization: StationService.to.currentStation.attributes!.organization!.data!.id!,
        nickname: playerNameController.text,
        scoreId: gameDetails.multiplayerGame!
    ) ;
    var myScore = joinMultiplayerGameData.attributes?.scores?.data?.firstWhereOrNull((element) => StationService.to.currentStation.id == element?.id ) ;
    Get.back();
    await Future.delayed(Duration(milliseconds: 500));
    Get.rootDelegate.toNamed(Routes.MULTIPLAYER_GUEST_GAME_STATUS, arguments: {
      "score" : myScore?.id,
      "name": playerNameController.text
    });

    Get.find<InactivityRedirectService>().userInteracted() ;
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

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
