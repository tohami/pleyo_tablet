import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/game_started_data.dart';
import 'package:pleyo_tablet_app/routes/app_pages.dart';

import '../../../../main.dart';

class GameStatusController extends SuperController<bool> {
  GameStatusController();

  bool isChampion = Get.rootDelegate.arguments()["mode"];

  int? points = Get.rootDelegate.arguments()["points"];

  String? playerName = Get.rootDelegate.arguments()["player_name"];

  GameStartedData? gameData = GameStartedData.fromJson(Get.rootDelegate.arguments()["game_data"]);

  DatabaseReference messageQueueRef = FirebaseDatabase.instance.ref("MessageQueue");

  late StreamSubscription messageQueueSubscription ;

  @override
  void onInit() {
    super.onInit();
    // change(null, status: RxStatus.success());

    messageQueueSubscription = messageQueueRef
        .limitToLast(1)
        .onChildAdded
        .listen((event) {
      Map? value = event.snapshot.value as Map?;

      if (value != null && (value["CommandeId"] == "GAME_STOPPED")) {
        var gameStartedData =
        GameStartedData.fromJson(value["Data"] as Map<dynamic, dynamic>);
        if (gameStartedData.idMachine.toString() == MACHINE_ID &&
            gameStartedData.idGame == gameStartedData.idGame &&
            gameStartedData.idVariation == gameStartedData.idVariation &&
            gameStartedData.playerNickName == playerName) {
          Get.rootDelegate.popRoute() ;
        }
      }
    });

    // Future.delayed(const Duration(seconds: 2)).then((value) {
    //   Get.rootDelegate.toNamed(Routes.GAME_RESULT, parameters: {
    //     "game_mode": isChampion.toString(),
    //     "points": points ?? "",
    //     "player_name": playerName ?? ""
    //   });
    // });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    messageQueueSubscription.cancel() ;
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  void stopGame() {
    var newCommand = messageQueueRef.push();

    newCommand
        .set({"CommandeId": "GAME_STOP", "Data": gameData?.toJson()});
  }
}
