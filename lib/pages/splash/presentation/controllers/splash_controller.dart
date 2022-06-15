import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/main.dart';
import 'package:pleyo_tablet_app/model/game_started_data.dart';

import '../../../../routes/app_pages.dart';
import '../../data/splash_repository.dart';

class SplashController extends SuperController<dynamic> with GetSingleTickerProviderStateMixin{

  late AnimationController _buttonAnimationController;
  RxBool isButtonTapDown = false.obs ;
  late Animation<double> buttonAnimation;

  SplashController({required this.splashRepository});

  final ISplashRepository splashRepository;
  DatabaseReference messageQueueRef = FirebaseDatabase.instance.ref("MessageQueue");
  DatabaseReference leaderBoardRef = FirebaseDatabase.instance.ref("GlobalLeaderboard");
  DatabaseReference gameHistoryRef = FirebaseDatabase.instance.ref("GameHistory");
  @override
  void onClose() {
    _buttonAnimationController.dispose() ;
    super.onClose();
  }
  @override
  void onInit() {
    super.onInit();

    _buttonAnimationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);

    buttonAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeIn,
      ),
    );
    try {
      _buttonAnimationController
          .repeat(reverse: true)
          .orCancel;
    }on TickerCanceled catch (e) {

    }

    messageQueueRef
        .limitToLast(1)
        .onChildAdded
        .listen((event) async{
      try {
        print(event.snapshot.value) ;
        Map? value = event.snapshot.value as Map?;

        if (value != null && (value["CommandeId"] == "GAME_STOPPED" ||
            value["CommandeId"] == "LEADERBOARD_PUSH")) {
          var gameStartedData = GameStartedData.fromJson(value["Data"] as Map<dynamic, dynamic>);
          Map historyStartDataJson = gameStartedData.toJson() ;
          historyStartDataJson.putIfAbsent("CreatedAt", () => DateTime.now().toIso8601String());
          DatabaseReference gameHistory = gameHistoryRef.push() ;
          gameHistory.set(
              historyStartDataJson
          ) ;
          gameStartedData.dateTime = DateTime
              .now()
              .millisecondsSinceEpoch;
          gameStartedData.isPartyMode = false;
          if (gameStartedData.idMachine.toString() == MACHINE_ID ) {
            if (value["CommandeId"] == "GAME_STOPPED") {
              Get.rootDelegate.popRoute();
            } else {
              // messageQueueSubscription.cancel();
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
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  onStartClicked() {
    Get.rootDelegate.offNamed(Routes.SCAN_QR);
  }
}
