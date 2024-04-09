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

  late Map<Game , List<GameVariant>> games =  groupBy(station.attributes!.gameVariants!.data! , (GameVariant item) => item.attributes!.game!.data!) ;
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
            if(Navigator.of(Get.context!).canPop()) {
              Navigator.of(Get.context!).pop();
            }
            Get.rootDelegate.toNamed(Routes.GAME_STATUS);
            gameStatus.value = 0 ;
            FirebaseCrashlytics.instance.log("Game started") ;
            break;
          case GameStatusType.FINISHED:
          case GameStatusType.CLOSED:
          case GameStatusType.CRASHED:
            FirebaseCrashlytics.instance.log("Game stopped by gamehub durring game starting") ;
            gameStatus.value = 0 ;
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

  void startGame(int variant,
      int diff) async {

    FirebaseCrashlytics.instance.log("Starting new game v $variant ,d $diff") ;
    var now = DateTime.now();
    gameStatus.value = 1;
    await Future.delayed(const Duration(seconds: 1));

    //check available balance
    try {
      //stop game before start new one
      FirebaseCrashlytics.instance.log("Stopping the old game ") ;
      await repository.updateScoreStatus("GAME_STOP", 0);
      await Future.delayed(Duration(seconds: 4)) ;
      var result = await repository.startGame(diff, variant, ticket.id!) ;
      FirebaseCrashlytics.instance.log("Sending start game success") ;
      await Future.delayed(Duration(seconds: 20)) ;
      if(gameStatus.value == 1) {
        gameStatus.value = 0 ;
        showAlert("Error", "Request timeout, unable to communicate with the server") ;
        FirebaseCrashlytics.instance.log("Start game timeout") ;
      }
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
}
