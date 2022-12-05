import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import "package:collection/collection.dart";

import '../../../../model/strapi/station.dart';
import '../../../../model/strapi/ticket.dart';
import '../../data/games_repository.dart';

class HomeController extends SuperController<bool> {
  Ticket ticket = StationService.to.currentTicket;
  Station station = StationService.to.currentStation;

  RxBool isLogoutActive = false.obs;

  RxBool isAddPlayerActive = false.obs;

  RxBool isChampoinship = true.obs;

  late Map<Game , List<GameVariant>> games =  groupBy(station.attributes!.gameVariants!.data! , (GameVariant item) => item.attributes!.game!.data!) ;
  final IGamesRepository repository ;
  HomeController({required this.repository});


  @override
  void onInit() async {
    super.onInit();
    try {
      change(null, status: RxStatus.success());

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
    if (isLogoutActive.value) {
      //logout the player
      Get.rootDelegate.offNamed(Routes.SPLASH);
    } else {
      isLogoutActive.value = true;
    }
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

  void startGame(int variant,
      int diff) async {

    var now = DateTime.now();
    gameStatus.value = 1;
    await Future.delayed(const Duration(seconds: 1));

    //check available balance
    try {
      var result = await repository.startGame(diff, variant, ticket.id!) ;
      // var currentPoints = codeRef.
      // var startGameData = StartGameData(
      //     difficultyPlayed: diff.toString(),
      //     gameName: game.gameName,
      //     idGame: game.idGame,
      //     idMachine: STATION_ID,
      //     idVariation: variant.idVariation,
      //     isOnPartyMode: (!(isChampoinship.value)).toString(),
      //     partyName: playerName,
      //     playerNickName: playerName,
      //     publicHashtag: qrCodeModel.value.publicHashTag
      //         ?.substring(qrCodeModel.value.publicHashTag!.length - 5),
      //     dateTime: DateTime.now().millisecondsSinceEpoch,
      //     globalLeaderboardName: "${game.gameName}_${now.year}");


      // subscription = messageQueueRef
      //     .limitToLast(1)
      //     .onChildAdded
      //     .timeout(const Duration(seconds: 30))
      //     .listen((event) async {
      //   print(event.snapshot.value) ;
      //
      //   final value = event.snapshot.value is List ? (event.snapshot.value as List)[0] : event.snapshot.value ;
      //
      //   if (value != null && value["CommandeId"] == "GAME_STARTED") {
      //     var gameStartedData =
      //         GameStartedData.fromJson(value["Data"] as Map<dynamic, dynamic>);
      //     if (gameStartedData.idMachine.toString() == STATION_ID &&
      //         gameStartedData.idGame.toString() == game.idGame &&
      //         gameStartedData.idVariation.toString() == variant.idVariation &&
      //         gameStartedData.playerNickName == playerName &&
      //         gameStartedData.gameDuration == -1 &&
      //         gameStartedData.score == -1) {
      //       if(Navigator.of(Get.context!).canPop()) {
      //         Navigator.of(Get.context!).pop();
      //       }
      //       gameStartedData.teamName = qrCodeModel.value.teamName ;
      //       gameStartedData.teamColor = qrCodeModel.value.teamColor ;
      //       Get.rootDelegate.toNamed(Routes.GAME_STATUS, arguments: {
      //         "game_data" : gameStartedData.toJson() ,
      //         "mode": isChampoinship.value,
      //         // "points": qrCodeModel.value.remainingCredit,
      //         "points": 0,
      //         "player_name": playerName
      //       });
      //     }
      //     event.snapshot.ref.remove() ;
      //     subscription?.cancel() ;
      //     gameStatus.value = 0;
      //   }
      // })..onError((e) {
      //   print("cancel maybe streem error");
      //   gameStatus.value = 0;
      //   subscription?.cancel() ;
      // });
      //
      // // gameStatus.value = 2 ;

      // throw Error() ;
    } catch (e) {
      print(e) ;
      // //return the credit if the game not started
      // print("cancel maybe error") ;
      // await currentQrCodeRef.update({
      //   "remainingCredit": ServerValue.increment(10),
      //   "isLocked": "false",
      // });
      // gameStatus.value = 0;
      // subscription?.cancel();
    }
  }
}
