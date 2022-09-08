import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
  DatabaseReference leaderBoardRef = FirebaseDatabase.instance.ref("GlobalLeaderboard");
  DatabaseReference gameHistoryRef = FirebaseDatabase.instance.ref("GameHistory");

  late StreamSubscription messageQueueSubscription ;

  @override
  void onInit() {
    super.onInit();
    // change(null, status: RxStatus.success());
    Map historyStartDataJson = gameData!.toJson() ;
    historyStartDataJson.putIfAbsent("CreatedAt", () => DateTime.now().toIso8601String());
    DatabaseReference gameHistory = gameHistoryRef.push() ;
    gameHistory.set(
      historyStartDataJson
    ) ;
    messageQueueSubscription = messageQueueRef
        .limitToLast(1)
        .onChildAdded
        .listen((event) async{
          try {
            Map? value = event.snapshot.value as Map?;

            if (value != null && (value["CommandeId"] == "GAME_STOPPED" ||
                value["CommandeId"] == "LEADERBOARD_PUSH")) {
              var gameStartedData =
              GameStartedData.fromJson(value["Data"] as Map<dynamic, dynamic>);
              gameStartedData.dateTime = DateTime
                  .now()
                  .millisecondsSinceEpoch;
              gameStartedData.isPartyMode = !isChampion;
              if (gameStartedData.idMachine.toString() == MACHINE_ID &&
                  gameStartedData.idGame == gameData?.idGame &&
                  gameStartedData.idVariation == gameData?.idVariation &&
                  gameStartedData.playerNickName == playerName) {
                if (value["CommandeId"] == "GAME_STOPPED") {
                  Get.back();
                } else {
                  messageQueueSubscription.cancel();
                  // gameStartedData.score = Random().nextInt(1000) ;
                  try {
                    var leaderBoardData = await leaderBoardRef.child(
                        gameStartedData.globalLeaderboardName!).get();
                    var leaderBoardItems = leaderBoardData.children.map((e) {
                      final leaderBoardItemValue = e.value is List ? (e
                          .value as List)[0] : e.value;

                      var leaderBoardItem =
                      GameStartedData.fromJson(leaderBoardItemValue);
                      return leaderBoardItem;
                    }).toList();

                    int currentPlayerScoreIndex = leaderBoardItems.indexWhere((
                        element) =>
                    element.playerNickName == gameStartedData.playerNickName &&
                        element.publicHashtag == gameStartedData.publicHashtag);
                    if (currentPlayerScoreIndex != -1) {
                      if (leaderBoardItems[currentPlayerScoreIndex].score! <
                          gameStartedData.score!) {
                        leaderBoardItems[currentPlayerScoreIndex] =
                            gameStartedData;
                      }
                    } else {
                      leaderBoardItems.add(gameStartedData);
                    }

                    leaderBoardItems.sort((a, b) {
                      return b.score!.compareTo(a.score!);
                    });

                    if (leaderBoardItems.length > 10) {
                      leaderBoardItems.removeRange(10, leaderBoardItems.length);
                    }
                    await leaderBoardRef.child(
                        gameStartedData.globalLeaderboardName!).set(
                        leaderBoardItems.map((e) => e.toJson()).toList()
                    );
                  } catch (e) {
                print(e) ;
                print(gameStartedData.globalLeaderboardName!) ;
                FirebaseCrashlytics.instance.recordError(e, null) ;
                    print("could not update leaderBoard");
                  }


                  //update alltime leaderBoard
                  var allTimeLeaderboardRef = FirebaseDatabase.instance.ref(
                      "AllTimeLeaderboard").child(gameStartedData.gameName!);
                  var leaderBoardData = await allTimeLeaderboardRef
                      .orderByChild("PublicHashtag").equalTo(
                      gameStartedData.publicHashtag).get();
                  //qrcode leaderboard
                  var leaderBoardItems = leaderBoardData.children.map((e) {
                    final leaderBoardItemValue = e.value is List ? (e
                        .value as List)[0] : e.value;

                    var leaderBoardItem =
                    MapEntry(
                        e.key, GameStartedData.fromJson(leaderBoardItemValue));
                    return leaderBoardItem;
                  }).toList();

                  int currentPlayerScoreIndex = leaderBoardItems.indexWhere((
                      element) =>
                  element.value.playerNickName ==
                      gameStartedData.playerNickName);
                  if (currentPlayerScoreIndex != -1) {
                    if (leaderBoardItems[currentPlayerScoreIndex].value.score! <
                        gameStartedData.score!) {
                      await allTimeLeaderboardRef.child(
                          leaderBoardItems[currentPlayerScoreIndex].key!).set(
                          gameStartedData.toJson()
                      );
                    }
                  } else {
                    allTimeLeaderboardRef.push().set(
                        gameStartedData.toJson()
                    );
                  }

                  Get.rootDelegate.offNamed(Routes.GAME_RESULT, parameters: {
                    "game_mode": isChampion.toString(),
                    "points": points.toString(),
                    "score": gameStartedData.score.toString(),
                    "player_name": gameStartedData.playerNickName ?? ""
                  });
                }
                Map historyEndDataJson = gameStartedData.toJson();
                historyEndDataJson.putIfAbsent(
                    "EndedAt", () => DateTime.now().toIso8601String());
                historyEndDataJson.putIfAbsent(
                    "CreatedAt", () => historyStartDataJson["CreatedAt"]);
                gameHistory.set(
                    historyEndDataJson
                );
              }
            }
          }catch (e){
            print(e);
            FirebaseCrashlytics.instance.recordError(e, null);
          }
    });

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
