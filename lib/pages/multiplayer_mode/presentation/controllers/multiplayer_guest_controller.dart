import 'dart:async';
import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import "package:collection/collection.dart";
import 'package:pleyo_tablet_app/model/strapi/join_multiplayer_game_message.dart';
import 'package:pleyo_tablet_app/model/strapi/station.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket.dart';
import 'package:pleyo_tablet_app/pages/multiplayer_mode/presentation/views/guest_name_dialog.dart';
import 'package:pleyo_tablet_app/services/InactivityRedirectService.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart' as sr;

import '../../../../model/start_game.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/alert.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../../home/data/games_repository.dart';
import '../../data/multiplayer_repository.dart';

class MultiplayerGuestController extends SuperController<bool> {
  final playerNameController = TextEditingController();
  final autoGeneratedNumberController = TextEditingController();
  late JoinMultiplayerGameDetails gameDetails ;
  RxBool goPlaying = false.obs;

  final IMultiplayerRepository multiplayerRepository;

  RxBool gameFail = false.obs;
  RxInt gameStatus = 0.obs;
  late StreamSubscription subscription;

  MultiplayerGuestController(
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
    subscription = StationService.to.gameStatus.listen((status) async {
      var newScore = sr.Score(
          id: status.data["id"],
          attributes: sr.Attributes.fromJson(status.data));
      print("---------------------- NEW EVENT --------------------------") ;
      print("${status.type} ${status.data} ") ;

      switch (status.type) {
        case GameStatusType.IDLE:
          gameStatus.value = 0;
          break;
        case GameStatusType.STARTING:
          gameStatus.value = 1;
          FirebaseCrashlytics.instance.log("game starting");
          break;
        case GameStatusType.STARTED:
          // Get.rootDelegate.backUntil(Routes.SELECT_GAME_DIFFICULTY) ;
          Get.rootDelegate.toNamed(
              "${Routes.MULTIPLAYER_GUEST_GAME_STATUS}/${Routes.MULTIPLAYER_GUEST_GAME_PLAY}");
          gameStatus.value = 0;
          FirebaseCrashlytics.instance.log("Game started");
          break;
        case GameStatusType.FINISHED:

          //should navigate to game score
          showDialogAfterGameFinished();
          break;
        case GameStatusType.CLOSED:
        case GameStatusType.CRASHED:
          FirebaseCrashlytics.instance
              .log("Game stopped by gamehub durring game starting");
          gameStatus.value = 0;
          print("Back to modes choose another game ") ;
          Get.rootDelegate.backUntil(Routes.MODE,
              popMode: PopMode.History);
          break;
      }
    });
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
    await multiplayerRepository.joinMultiplayerGame(
        station: StationService.to.currentStation.id!,
        organization: StationService.to.currentStation.attributes!.organization!.data!.id!,
        nickname: playerNameController.text,
      scoreId: gameDetails.multiplayerGame!
    ) ;
    Get.back();
    await Future.delayed(Duration(milliseconds: 500));
    Get.rootDelegate.toNamed(Routes.MULTIPLAYER_GUEST_GAME_STATUS);

      Get.find<InactivityRedirectService>().userInteracted() ;
  }

  void stopGame(String reason) async {
    var exit = await Get.dialog(
      AlertDialogWidget(
          content: 'You will lose this game’s progress. Sure? ',
          actionCancelText: 'Quit',
          actionAcceptText: 'Resume',
          onCancelClicked: () => {Get.back(result: true)},
          onAcceptClicked: () => {Get.back(result: false)}),
      barrierDismissible: false
    );
    if (!exit) return;

    try {
      FirebaseCrashlytics.instance.log("Stopping the game by tablet");
      Get.rootDelegate.backUntil(Routes.MODE,
          popMode: PopMode.History);

      //todo fix
      // multiplayerRepository.updateScoreStatus(
      //     "GAME_STOP", StationService.to.gameStatus.value.data["id"] , reason: reason);

      // _groupCompetition = await gamesRepository.getCompetition(_groupCompetition.id!);
    } catch (e , stacktrace) {
      print(e);
      FirebaseCrashlytics.instance.log("Stopping game Error");
      FirebaseCrashlytics.instance.recordError(e, stacktrace,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true);
    }
    // var newCommand = messageQueueRef.push();
    //
    // newCommand
    //     .set({"CommandeId": "GAME_STOP", "Data": gameData?.toJson()});
  }

  showDialogAfterGameFinished() async {

    Get.rootDelegate.backUntil(Routes.MODE);

    Future.delayed(const Duration(seconds: 1));
    //todo fix
    // gamesRepository.updateScoreStatus(
    //     "GAME_STOP", StationService.to.gameStatus.value.data["id"] , reason: "Stop game automatically after its finished");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    subscription.cancel();
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
