import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/machine_model.dart';
import 'package:pleyo_tablet_app/model/qrcode_model.dart';
import 'package:pleyo_tablet_app/model/start_game_data.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

import '../../../../model/game_model.dart';

class HomeController extends SuperController<bool> {
  Rx<QrCodeModel> qrCodeModel = Rx<QrCodeModel>(Get.rootDelegate.arguments());

  RxBool isLogoutActive = false.obs;

  RxBool isAddPlayerActive = false.obs;

  RxBool isChampion = true.obs;

  final RxList<GameModel> games = RxList<GameModel>([]);

  HomeController();

  String username = "";

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
      var machineEntity = await machineRef.child(MACHINE_ID).get();
      var machine =
          MachineModel.fromJson(machineEntity.value as Map<dynamic, dynamic>);

      var gamesEntity = await gamesRef.get();
      games.addAll(gamesEntity.children.map((e) {
        var game = GameModel.fromJson(e.value as Map<dynamic, dynamic>);

        GameVariationList? machineVariation = machine.gameVariationList!
            .firstWhereOrNull((element) => element.idGame == game.idGame);

        if (machineVariation == null) {
          game.variationList?.clear();
        } else {
          List<String?> machineVariationIds =
          machineVariation.variationList!.map((e) => e.idVariation)
              .toList();
          //remove games thats not included in the machine
          game.variationList?.removeWhere((element) => !machineVariationIds.contains(element.idVariation));
        }

        return game;
      }));
    } catch (e) {
      print(e);
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
    isChampion.value = val;
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
    var qrCode = qrCodeModel.value;
    var players = qrCode.players ?? [];
    if (players.contains(val)) {
      players.remove(val);
      players.add(val);
    }
    qrCodeModel.value = qrCode;
    print("add player");

    try {
      await qrCodesRef
          .child("${qrCode.publicHashTag!}/players")
          .push()
          .set({val});
      // print(res)
    } catch (e) {
      print(e);
    }
  }

  void startGame(GameModel game, VariationList variant, String playerName,
      int diff) async {
    var now = DateTime.now();
    //check available balance
    var currentQrCodeRef = qrCodesRef.child(qrCodeModel.value.publicHashTag!);
    var qrCodeEntity = await currentQrCodeRef.get();
    var qrCode =
        QrCodeModel.fromJson(qrCodeEntity.value as Map<dynamic, dynamic>);
    if (qrCode.isLocked == "true") {
      Get.snackbar("Error", "Try Later");
      return;
    }
    await currentQrCodeRef.child("isLocked").set("true");
    if (qrCode.remainingCredit! < 10) {
      Get.snackbar("Error", "You don`t have enough points ");
      return;
    }

    // var currentPoints = codeRef.
    var startGameData = StartGameData(
        difficultyPlayed: diff.toString(),
        gameName: game.gameName,
        idGame: game.idGame,
        idMachine: "0",
        idVariation: variant.idVariation,
        isOnPartyMode: (!isChampion.value).toString(),
        partyName: playerName,
        playerNickName: playerName,
        publicHashtag: qrCodeModel.value.publicHashTag,
        globalLeaderboardName: "${now.month}_${now.year}");
    var newCommand = messageQueueRef.push();
    newCommand
        .set({"CommandeId": "GAME_START", "Data": startGameData.toJson()});

    await currentQrCodeRef
        .child("remainingCredit")
        .set(qrCode.remainingCredit! - 10);
  }
}
