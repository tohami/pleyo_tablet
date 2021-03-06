import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/game_started_data.dart';
import 'package:pleyo_tablet_app/model/machine_model.dart';
import 'package:pleyo_tablet_app/model/qrcode_model.dart';
import 'package:pleyo_tablet_app/model/start_game_data.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

import '../../../../model/game_model.dart';

class HomeController extends SuperController<bool> {
  Rx<QrCodeModel> qrCodeModel = Rx<QrCodeModel>(Get.rootDelegate.arguments());

  RxBool isLogoutActive = false.obs;

  RxBool isAddPlayerActive = false.obs;

  RxBool isChampoinship = true.obs;

  final RxList<GameModel> games = RxList<GameModel>([]);

  HomeController();

  RxString selectedPlayerName = "".obs;

  DatabaseReference gamesRef = FirebaseDatabase.instance.ref("Game");
  DatabaseReference machineRef = FirebaseDatabase.instance.ref("Machine");
  DatabaseReference qrCodesRef = FirebaseDatabase.instance.ref("QRCode");
  DatabaseReference messageQueueRef =
      FirebaseDatabase.instance.ref("MessageQueue");

  @override
  void onInit() async {
    super.onInit();
    change(null, status: RxStatus.success());
    try {
      if (qrCodeModel.value.players != null &&
          qrCodeModel.value.players!.isNotEmpty) {
        selectedPlayerName.value = qrCodeModel.value.players!.last;
      }
      var machineEntity = await machineRef.child(MACHINE_ID).get();
      final machineValue = machineEntity.value is List ? (machineEntity.value as List)[0] : machineEntity.value ;
      var machine =
          MachineModel.fromJson(machineValue);

      var gamesEntity = await gamesRef.get();
      games.addAll(gamesEntity.children.map((e) {
        final gameValue = e.value is List ? (e.value as List)[0] : e.value ;

        var game = GameModel.fromJson(gameValue);

        GameVariationList? machineVariation = machine.gameVariationList
            ?.firstWhereOrNull((element) => element.idGame == game.idGame);

        if (machineVariation == null ||
            machineVariation.variationList == null) {
          game.variationList?.clear();
        } else {
          List<String?> machineVariationIds = machineVariation.variationList!
              .map((e) => e.idVariation)
              .toList();
          //remove games thats not included in the machine
          game.variationList?.removeWhere(
              (element) => !machineVariationIds.contains(element.idVariation));
        }

        return game;
      }));

      qrCodesRef.child(qrCodeModel.value.publicHashTag!).onValue.listen((event) {
        final qrCodeValue = event.snapshot.value is List ? (event.snapshot.value as List)[0] : event.snapshot.value ;

        qrCodeModel.value = QrCodeModel.fromJson(qrCodeValue);
      });


      messageQueueRef
          .limitToLast(1)
          .onChildAdded
          .timeout(const Duration(seconds: 5))
          .listen((event) {
        print("Msg" + event.snapshot.value.toString()) ;

      }).onError((e) {
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

  void addPlayer(String val) async {
    if (val.trim().length < 4) {
      isAddPlayerActive.value = false;
      return;
    }
    var qrCode = qrCodeModel.value;
    List<String> players = qrCode.players?.toList() ?? [];
    if (!players.contains(val)) {
      players.add(val);
    }
    qrCode.players = players;
    qrCodeModel.value = qrCode;
    print("add player");

    try {
      await qrCodesRef
          .child(qrCodeModel.value.publicHashTag!)
          .child("players")
          .set(players);
      selectedPlayerName.value = val;
      // print(res)
    } catch (e) {
      print(e);
    } finally {
      isAddPlayerActive.value = false;
    }
  }

  //0 nothing
  //1 starting
  //2 started
  RxInt gameStatus = 0.obs;

  void startGame(GameModel game, VariationList variant, String playerName,
      int diff) async {
    var now = DateTime.now();
    StreamSubscription? subscription;
    gameStatus.value = 1;
    await Future.delayed(const Duration(seconds: 1));

    //check available balance
    var currentQrCodeRef = qrCodesRef.child(qrCodeModel.value.publicHashTag!);
    try {
      var transactionResult = await currentQrCodeRef.runTransaction((value) {
        if (value == null) {
          return Transaction.abort();
        }

        var qrCode = QrCodeModel.fromJson(value as Map<dynamic, dynamic>);

        if (qrCode.isLocked == "true") {
          Get.snackbar("Error",
              "Your card currently used to run game on other machine, please try again");
          return Transaction.abort();
        } else if ((qrCode.remainingCredit ?? 0) < 10) {
          Get.snackbar(
              "Error", "You don't have enough points to run this game ");
          return Transaction.abort();
        }

        qrCode.remainingCredit = qrCode.remainingCredit! - 10;
        qrCode.isLocked = "true";

        return Transaction.success(qrCode.toJson());
      });

      if (!transactionResult.committed) {
        gameStatus.value = 0;
        return;
      }

      // var currentPoints = codeRef.
      var startGameData = StartGameData(
          difficultyPlayed: diff.toString(),
          gameName: game.gameName,
          idGame: game.idGame,
          idMachine: MACHINE_ID,
          idVariation: variant.idVariation,
          isOnPartyMode: (!(isChampoinship.value)).toString(),
          partyName: playerName,
          playerNickName: playerName,
          publicHashtag: qrCodeModel.value.publicHashTag
              ?.substring(qrCodeModel.value.publicHashTag!.length - 5),
          dateTime: DateTime.now().millisecondsSinceEpoch,
          globalLeaderboardName: "${game.gameName}_${now.month}_${now.year}");

      var newCommand = messageQueueRef.push();

      newCommand
          .set({"CommandeId": "GAME_START", "Data": startGameData.toJson()});

      subscription = messageQueueRef
          .limitToLast(1)
          .onChildAdded
          .timeout(const Duration(seconds: 30))
          .listen((event) async {
        print(event.snapshot.value) ;

        final value = event.snapshot.value is List ? (event.snapshot.value as List)[0] : event.snapshot.value ;

        if (value != null && value["CommandeId"] == "GAME_STARTED") {
          var gameStartedData =
              GameStartedData.fromJson(value["Data"] as Map<dynamic, dynamic>);
          if (gameStartedData.idMachine.toString() == MACHINE_ID &&
              gameStartedData.idGame.toString() == game.idGame &&
              gameStartedData.idVariation.toString() == variant.idVariation &&
              gameStartedData.playerNickName == playerName &&
              gameStartedData.gameDuration == -1 &&
              gameStartedData.score == -1) {
            if(Navigator.of(Get.context!).canPop()) {
              Navigator.of(Get.context!).pop();
            }
            Get.rootDelegate.toNamed(Routes.GAME_STATUS, arguments: {
              "game_data" : gameStartedData.toJson() ,
              "mode": isChampoinship.value,
              "points": qrCodeModel.value.remainingCredit,
              "player_name": playerName
            });
          }
          event.snapshot.ref.remove() ;
          subscription?.cancel() ;
          currentQrCodeRef.update({
            "isLocked": "false",
          });
          gameStatus.value = 0;
        }
      })..onError((e) {
        print("cancel maybe streem error");
        currentQrCodeRef.update({
          "remainingCredit": ServerValue.increment(10),
          "isLocked": "false",
        });
        gameStatus.value = 0;
        subscription?.cancel() ;
      });

      // gameStatus.value = 2 ;

      // throw Error() ;
    } catch (e) {
      //return the credit if the game not started
      print("cancel maybe error") ;
      await currentQrCodeRef.update({
        "remainingCredit": ServerValue.increment(10),
        "isLocked": "false",
      });
      gameStatus.value = 0;
      subscription?.cancel();
    }
  }
}
