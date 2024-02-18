import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import "package:collection/collection.dart";
import 'package:pleyo_tablet_app/model/strapi/station.dart';
import 'package:pleyo_tablet_app/model/strapi/ticket.dart';
import 'package:pleyo_tablet_app/pages/single_player_mode/data/single_play_repository.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart' as sr;

import '../../../../model/start_game.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/alert.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../../home/data/games_repository.dart';

class SinglePlayerModeController extends SuperController<bool> {
  final playerNameController = TextEditingController();
  final autoGeneratedNumberController = TextEditingController();
  RxBool goPlaying = false.obs;

  Station station = StationService.to.currentStation;
  late Map<Game, List<GameVariant>> games = groupBy(
      station.attributes!.gameVariants!.data!,
      (GameVariant item) => item.attributes!.game!.data!);

  Ticket? currentPlayer;

  final ISinglePlayRepository singlePlayRepository;
  final IGamesRepository gamesRepository;

  Rx<GameVariant?> selectedVariant = Rx(null);

  Rx<Game?> selectedGame = Rx(null);

  RxBool gameFail = false.obs;
  RxInt gameStatus = 0.obs;
  late StreamSubscription subscription;

  int? selectedDifficulty;

  SinglePlayerModeController(
      {required this.singlePlayRepository, required this.gamesRepository});

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

    subscription = StationService.to.gameStatus.listen((status) async {
      print("from game playing ${status.type}");
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
          if (selectedVariant.value?.attributes != null) {
            Get.rootDelegate.toNamed(
                "${Routes.SINGLE_PLAY_LANDING}/${Routes.SINGLE_PLAY_GAME_PLAY}");
            gameStatus.value = 0;
          }
          FirebaseCrashlytics.instance.log("Game started");
          break;
        case GameStatusType.FINISHED:
          var newScore = sr.Score(
              id: status.data["id"],
              attributes: sr.Attributes.fromJson(status.data));
          //should navigate to game score
          Get.rootDelegate.backUntil(
              "${Routes.SINGLE_PLAY_LANDING}/${Routes.SINGLE_PLAY_SELECT_GAME}" ,popMode: PopMode.History);
          break;
        case GameStatusType.CLOSED:
        case GameStatusType.CRASHED:
          FirebaseCrashlytics.instance
              .log("Game stopped by gamehub durring game starting");
          gameStatus.value = 0;
          Get.rootDelegate.backUntil(
              "${Routes.SINGLE_PLAY_LANDING}/${Routes.SINGLE_PLAY_SELECT_GAME}", popMode: PopMode.History);
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

  void startGame(int diff) async {
    this.selectedDifficulty = diff;
    gameFail.value = false;
    int variant = selectedVariant.value!.id!;
    FirebaseCrashlytics.instance.log("Starting new game v $variant ,d $diff");
    Get.rootDelegate.toNamed(
        "${Routes.SINGLE_PLAY_LANDING}/${Routes.SINGLE_PLAY_GAME_STATUS}");
    var now = DateTime.now();
    gameStatus.value = 1;
    await Future.delayed(const Duration(seconds: 1));

    //check available balance
    try {
      //stop game before start new one
      FirebaseCrashlytics.instance.log("Stopping the old game ");
      print("start new game");
      var result =
          await gamesRepository.startGame(diff, variant, currentPlayer!.id!);
      FirebaseCrashlytics.instance.log("Sending start game success");
      print("Sending start game success");
      await Future.delayed(Duration(seconds: 40));
      if (gameStatus.value == 1) {
        gameStatus.value = 0;
        gameFail.value = true;
        FirebaseCrashlytics.instance.log("Start game timeout");
      }
    } catch (e) {
      if (e is MapEntry) {
        showAlert("Error", e.value);
      } else {
        showAlert("Error", "Connection error");
      }
      gameStatus.value = 0;
      FirebaseCrashlytics.instance.log("Start game error");
      await FirebaseCrashlytics.instance.recordError(e, null,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true);
    }
  }

  RxBool createTicketLoading = false.obs ;
  void createTicket() async {
    try {
      createTicketLoading.value = true;
      currentPlayer = await singlePlayRepository.createSinglePlayTicket(
          StationService.to.currentStation.id!,
          TicketAttributes(
            nickname:
            playerNameController.text + autoGeneratedNumberController.text,
            organization: StationService
                .to.currentStation.attributes?.organization?.data?.id,
          ));

      Get.rootDelegate
          .toNamed(
          "${Routes.SINGLE_PLAY_LANDING}/${Routes.SINGLE_PLAY_WELCOME}");
      await Future.delayed(4.seconds);
      Get.rootDelegate.toNamed(
          "${Routes.SINGLE_PLAY_LANDING}/${Routes.SINGLE_PLAY_SELECT_GAME}");
    }catch (e) {
      showAlert("Error", "Connection error");
    }finally {
      createTicketLoading.value = false;
    }
  }

  void stopGame() async {
    var exit = await Get.dialog(
      AlertDialogWidget(
          content: 'You will lose this game’s progress. Sure? ',
          actionCancelText: 'Quit',
          actionAcceptText: 'Resume',
          onCancelClicked: () => {Get.back(result: true)},
          onAcceptClicked: () => {Get.back(result: false)}),
    );
    if (!exit) return;

    try {
      FirebaseCrashlytics.instance.log("Stopping the game by tablet");
      Get.rootDelegate.backUntil(
          "${Routes.SINGLE_PLAY_LANDING}/${Routes.SINGLE_PLAY_SELECT_GAME}",popMode: PopMode.History);

      gamesRepository.updateScoreStatus(
          "GAME_STOP", StationService.to.gameStatus.value.data["id"]);

      // _groupCompetition = await gamesRepository.getCompetition(_groupCompetition.id!);
    } catch (e) {
      print(e);
      FirebaseCrashlytics.instance.log("Stopping game Error");
      FirebaseCrashlytics.instance.recordError(e, null,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true);
    }
    // var newCommand = messageQueueRef.push();
    //
    // newCommand
    //     .set({"CommandeId": "GAME_STOP", "Data": gameData?.toJson()});
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
}
