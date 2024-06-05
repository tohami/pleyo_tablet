import 'dart:async';
import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import "package:collection/collection.dart";
import 'package:pleyo_tablet_app/widgets/alert_dialog.dart';

import '../../../../model/start_game.dart';
import '../../../../model/strapi/station.dart';
import '../../../../model/strapi/ticket.dart';
import '../../../../widgets/alert.dart';
import '../../data/games_repository.dart';

class HomeController extends SuperController<bool> {
  Ticket ticket = StationService.to.currentTicket;
  Station station = StationService.to.currentStation;

  RxBool isLogoutActive = false.obs;

  RxBool isAddPlayerActive = false.obs;

  RxBool isChampoinship = true.obs;

  Rx<GameVariant?> selectedVariant = Rx(null);
  Rx<Game?> selectedGame = Rx(null);
  RxBool gameFail = false.obs;
  int? selectedDifficulty;

  late Map<Game, List<GameVariant>> games = groupBy(
      station.attributes!.organization!.data!.attributes!.configuration!.data!.attributes!.competitionGameVariants!.data!,
          (GameVariant item) => item.attributes!.game!.data!);
  final IGamesRepository repository ;
  HomeController({required this.repository});
  late StreamSubscription subscription ;
  @override
  void onInit() async {
    super.onInit();
    try {
      change(null, status: RxStatus.success());

      subscription = StationService.to.gameStatus.listen((status) {
        print("Home : ${status.type}") ;
        switch(status.type) {

          case GameStatusType.IDLE:
            gameStatus.value = 0 ;
            break;
          case GameStatusType.STARTING:
            gameStatus.value = 1 ;
            FirebaseCrashlytics.instance.log("game starting");
            break;
          case GameStatusType.STARTED:
            // if(Navigator.of(Get.context!).canPop()) {
            //   Navigator.of(Get.context!).pop();
            // }
            // Get.rootDelegate.toNamed(Routes.GAME_STATUS);
            if (selectedVariant.value?.attributes != null) {
              Get.rootDelegate.toNamed(
                  "${Routes.HOME}/${Routes.COMPETITION_GAME_PLAY}");
              gameStatus.value = 0;
            }
            gameStatus.value = 0 ;
            FirebaseCrashlytics.instance.log("Game started") ;
            break;
          case GameStatusType.FINISHED:
            showDialogAfterGameFinished();
            break;
          case GameStatusType.CLOSED:
          case GameStatusType.CRASHED:
            FirebaseCrashlytics.instance.log("Game stopped by gamehub durring game starting") ;
            gameStatus.value = 0 ;
            Get.rootDelegate.backUntil(Routes.HOME, popMode: PopMode.History);
            break;
            break;
        }
      });

    } catch (e) {
      printError(info: e.toString());
    }

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // ignore: avoid_print
      subscription.cancel() ;
    print('onClose called');
    super.onClose();
  }

  @override
  void didChangeMetrics() {
    // ignore: avoid_print
    print('the window size did change');
    super.didChangeMetrics();
  }

  @override
  void didChangePlatformBrightness() {
    // ignore: avoid_print
    print('platform change ThemeMode');
    super.didChangePlatformBrightness();
  }

  @override
  Future<bool> didPushRoute(String route) {
    // ignore: avoid_print
    print('the route $route will be open');
    return super.didPushRoute(route);
  }

  @override
  Future<bool> didPopRoute() {
    // ignore: avoid_print
    print('the current route will be closed');
    return super.didPopRoute();
  }

  @override
  void onDetached() {
    // ignore: avoid_print
    print('onDetached called');
  }

  @override
  void onInactive() {
    // ignore: avoid_print
    print('onInative called');
  }

  @override
  void onPaused() {
    // ignore: avoid_print
    print('onPaused called');
  }

  @override
  void onResumed() {
    // ignore: avoid_print
    print('onResumed called');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void changeMode(bool val) {
    isChampoinship.value = val;
  }

  void onLogoutClicked() {
    // if (isLogoutActive.value) {
      //logout the player
      Get.rootDelegate.offNamed(Routes.SCAN_QR);
    // } else {
    //   isLogoutActive.value = true;
    // }
  }

  void onAddPlayerClicked() {
    if (isAddPlayerActive.value) {
      //logout the player

    } else {
      isAddPlayerActive.value = true;
    }
  }

  // void addPlayer(String val) async {
  //   if (val.trim().length < 4) {
  //     isAddPlayerActive.value = false;
  //     return;
  //   }
  //   var qrCode = qrCodeModel.value;
  //   List<String> players = qrCode.players?.toList() ?? [];
  //   if (!players.contains(val)) {
  //     players.add(val);
  //   }
  //   qrCode.players = players;
  //   qrCodeModel.value = qrCode;
  //   print("add player");
  //
  //   try {
  //     await qrCodesRef
  //         .child(qrCodeModel.value.publicHashTag!)
  //         .child("players")
  //         .set(players);
  //     selectedPlayerName.value = val;
  //     // print(res)
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     isAddPlayerActive.value = false;
  //   }
  // }

  //0 nothing
  //1 starting
  //2 started
  RxInt gameStatus = 0.obs;
  Timer? retryTimer ;

  void startGame(int diff) async {
    this.selectedDifficulty = diff;
    gameFail.value = false;
    int variant = selectedVariant.value!.id!;
    FirebaseCrashlytics.instance.log("Starting new game v $variant ,d $diff") ;
    Get.rootDelegate.toNamed(
        "${Routes.HOME}/${Routes.COMPETITION_GAME_STATUS}");

    var now = DateTime.now();
    gameStatus.value = 1;
    await Future.delayed(const Duration(seconds: 1));

    //check available balance
    try {
      var result = await repository.startGame(diff, variant, ticket.id!) ;
      FirebaseCrashlytics.instance.log("Sending start game success ${result?.id}") ;
      print("Sending start game success ${result?.id}") ;

      retryTimer?.cancel() ;
      retryTimer = Timer(Duration(seconds: 40), () {
        if(gameStatus.value == 1) {
          gameStatus.value = 0 ;
          gameFail.value = true;
          showAlert("Error", "Request timeout, unable to communicate with the server") ;
          FirebaseCrashlytics.instance.log("Start game timeout") ;
        }
      });
    } catch (e) {
      if(e is MapEntry){
        showAlert("Error", e.value) ;
      }else {
        showAlert("Error", "Connection error");
      }
      gameStatus.value = 0;
      FirebaseCrashlytics.instance.log("Start game error") ;
      await FirebaseCrashlytics.instance.recordError(
          e,
          null,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true
      );
    }
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
      Get.rootDelegate.backUntil(Routes.HOME, popMode: PopMode.History);

      repository.updateScoreStatus(
          "GAME_STOP", StationService.to.gameStatus.value.data["id"] , reason: reason);

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
    // Create a delayed future that represents the timeout.
    var timeoutFuture = Future.delayed(const Duration(seconds: 30), () => true);

    // Show the dialog and wait for the user's response or the timeout, whichever comes first.
    var exit = await Future.any([
      Get.dialog(AlertDialogWidget(
        content: 'Game is finished, what do you want?',
        actionCancelText: 'Exit',
        actionAcceptText: 'Play again',
        onCancelClicked: () => Get.back(result: true), // Note: Use Get.back(result: true) instead of a set
        onAcceptClicked: () => Get.back(result: false),
      ) , barrierDismissible: false),
      timeoutFuture
    ]);

    if (exit) {
      Get.rootDelegate.backUntil(Routes.MODE);
    } else {
      Get.rootDelegate.backUntil(Routes.HOME, popMode: PopMode.History);
    }
    Future.delayed(const Duration(seconds: 1));
    repository.updateScoreStatus(
        "GAME_STOP", StationService.to.gameStatus.value.data["id"] , reason: "Stop game automatically after its finished");
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

}
