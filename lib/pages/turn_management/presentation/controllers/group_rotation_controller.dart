import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/model/strapi/group_competition.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart' as sr;
import 'package:pleyo_tablet_app/model/strapi/scores_response.dart' as ld;
import 'package:pleyo_tablet_app/routes/app_pages.dart';

import '../../../../model/start_game.dart';
import '../../../../model/strapi/game_difficulty.dart';
import '../../../../services/station_service.dart';
import '../../../../widgets/alert.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../../home/data/games_repository.dart';

class GroupRotationController extends SuperController<bool> {
  GroupCompetition _groupCompetition = Get.rootDelegate.arguments();

  int get numberOfTurns => _groupCompetition.playerCredit! ;
  int get numberOfPlayers => _groupCompetition.playersCount! ;
  Attributes? get gameVariant => _groupCompetition.gameVariant?.attributes ;
  List<GameDifficulty>? get gameDifficulties => _groupCompetition.gameVariant?.attributes?.gameDifficulties?.data ;
  GameDifficulty? get defaultDifficulty => gameDifficulties?[0] ;

  RxList<Ticket> players = RxList([]) ;
  Rx<Ticket?> currentPlayer = Rx(null) ;


  final groupEmailController = TextEditingController();
  RxBool gameFail = false.obs;
  RxBool isEmailEnabled = false.obs;
  RxBool isEmailValid = false.obs;
  RxBool isEmailAdded = false.obs;
  RxInt remainingSeconds = 20.obs;

  final IGamesRepository gamesRepository ;

  GroupRotationController({required this.gamesRepository}) ;
  late StreamSubscription subscription ;
  RxInt gameStatus = 0.obs;

  late RxList<ld.Score> leaderBoardList = RxList<ld.Score>([]);

  @override
  void onInit() {
    super.onInit();
    groupEmailController.addListener(() {
      if (groupEmailController.text.isNotEmpty &&
          isValidEmail(groupEmailController.text)) {
        isEmailValid.value = true;
      } else {
        isEmailValid.value = false;
      }
    });
    players.value = _groupCompetition.tickets??[] ;
    currentPlayer.value = _groupCompetition.currentPlayerTurn ;

    change(null, status: RxStatus.success());
    subscription = StationService.to.gameStatus.listen((status) async{
      var newScore = sr.Score(
          id: status.data["id"],
          attributes: sr.Attributes.fromJson(status.data));
      var competitions = newScore.attributes?.competitions ;

      if(competitions == null || competitions.indexWhere((element) => element.id == _groupCompetition.id) == -1){
        print("---------------------- THIS EVENT IS NOT OURS --------------------------") ;
        return  ;
      }
      switch(status.type) {

        case GameStatusType.IDLE:
          gameStatus.value = 0 ;
          break;
        case GameStatusType.STARTING:
          gameStatus.value = 1 ;
          FirebaseCrashlytics.instance.log("game starting");
          break;
        case GameStatusType.STARTED:
          // Get.rootDelegate.backUntil(Routes.SELECT_GAME_DIFFICULTY) ;
          print("--------------------------------------------> ${status.type} ${status.data["id"]}") ;
          print("--------------------------------------------> to GAME PLAY") ;
          Get.rootDelegate.toNamed("${Routes.GROUP_TURN_LANDING}/${Routes.GROUP_TURN_GAME_PLAY}");
          gameStatus.value = 0 ;
          FirebaseCrashlytics.instance.log("Game started") ;
          break;
        case GameStatusType.FINISHED:
        case GameStatusType.CLOSED:
          // gameStatus.value = 0;

          if (newScore.attributes?.competitions?[0].isEnded == true) {
            print("--------------------------------------------> ${status.type} ${status.data["id"]}") ;
            print("--------------------------------------------> back to TURN") ;
            Get.rootDelegate.backUntil(Routes.GROUP_TURN_LANDING);
            await Future.delayed(500.milliseconds);
            print("--------------------------------------------> go to FINAL RESULT") ;
            getLeaderboard();
            Get.rootDelegate.toNamed(
                "${Routes.GROUP_TURN_LANDING}/${Routes.GROUP_TURN_RESULT}");
            return;
          }
          players.value = newScore.attributes?.competitions?[0].tickets
                  ?.map((e) => e.mapTicketsToTicket())
                  .toList() ??
              [];
          currentPlayer.value = newScore
              .attributes?.competitions?[0].currentPlayerTurn
              ?.mapTicketsToTicket();
          print("--------------------------------------------> ${status.type} ${status.data["id"]}") ;
          print("--------------------------------------------> back to TURN") ;
          Get.rootDelegate.backUntil(Routes.GROUP_TURN_LANDING);
          startTimer();
          break;
        case GameStatusType.CRASHED:
        gameStatus.value = 0;
          FirebaseCrashlytics.instance
              .log("Game stopped by gamehub durring game starting");
          print("--------------------------------------------> ${status.type} ${status.data["id"]}") ;
          print("--------------------------------------------> back to TURN") ;
          Get.rootDelegate.backUntil(Routes.GROUP_TURN_LANDING);
          startTimer();
          break;
      }
    });
  }


  void refreshCompetitionData () {

  }

  @override
  void onReady() {
    super.onReady();
    startTimer() ;
  }
  Timer? timer ;
  startTimer() {
    timer?.cancel() ;
    var counter = 20;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      counter--;
      remainingSeconds.value = counter ;
      if (counter == 0) {
        print('Cancel timer');
        timer.cancel();
        startGame(defaultDifficulty!.id!) ;
      }
    });
  }

  @override
  void onClose() {
    timer?.cancel() ;
    subscription.cancel() ;
    super.onClose();
  }

  List<Score> getPlayerScores (Ticket player) {
    return player.scores?.where((element) => element.score != null).toList()??[];
  }

  // RxInt gameStatus = 0.obs;

  void startGame( int diff) async {
    timer?.cancel() ;
    gameFail.value = false ;
    int variant = _groupCompetition.gameVariant!.id! ;
    FirebaseCrashlytics.instance.log("Starting new game v $variant ,d $diff") ;
    print("--------------------------------------------> START NEW GAME $variant ,d $diff") ;
    print("--------------------------------------------> GO TO GAME STATUS") ;
    Get.rootDelegate.toNamed("${Routes.GROUP_TURN_LANDING}/${Routes.GROUP_TURN_GAME_STATUS}");
    var now = DateTime.now();
    gameStatus.value = 1;
    await Future.delayed(const Duration(seconds: 1));

    //check available balance
    try {
      //stop game before start new one
      FirebaseCrashlytics.instance.log("Stopping the old game ") ;
      var result = await gamesRepository.startGame(diff, variant, currentPlayer.value!.id!) ;
      print("--------------------------------------------> START NEW GAME $variant ,d $diff API RESULT ${result.id}") ;
      FirebaseCrashlytics.instance.log("Sending start game success") ;

      await Future.delayed(Duration(seconds: 30)) ;
      if(gameStatus.value == 1) {
        gameStatus.value = 0 ;
        gameFail.value = true ;
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

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  void stopGame()async {
   var exit = await Get.dialog(
      AlertDialogWidget(
          content:
          'You will lose this game’s progress. Sure? ',
          actionCancelText: 'Quit',
          actionAcceptText: 'Resume',
          onCancelClicked: () => {
            Get.back(result: false)
          },
          onAcceptClicked: () => {
            Get.back(result: true)
          }),
     barrierDismissible: false
    );
   if(exit == true)
     return ;

    try {
      FirebaseCrashlytics.instance.log("Stopping the game by tablet") ;
      print("--------------------------------------------> STOP GAME") ;
      var newScore = await gamesRepository.updateScoreStatus("GAME_STOP",
          StationService.to.gameStatus.value.data["id"]);

      players.value = newScore.attributes?.competitions?[0].tickets?.map((e) => e.mapTicketsToTicket()).toList() ?? [] ;
      currentPlayer.value = newScore.attributes?.competitions?[0].currentPlayerTurn?.mapTicketsToTicket() ;

      if(newScore.attributes?.competitions?[0].isEnded == true){
        print("--------------------------------------------> BACK TO LANDING") ;
        getLeaderboard();
        Get.rootDelegate.backUntil(Routes.GROUP_TURN_LANDING) ;
        await Future.delayed(500.milliseconds);
        print("--------------------------------------------> GO TO RESULT") ;
        Get.rootDelegate.toNamed("${Routes.GROUP_TURN_LANDING}/${Routes.GROUP_TURN_RESULT}") ;
        return ;
      }

      Get.rootDelegate.backUntil(Routes.GROUP_TURN_LANDING);
      startTimer() ;
      // _groupCompetition = await gamesRepository.getCompetition(_groupCompetition.id!);
    }catch (e){
      print(e) ;
      FirebaseCrashlytics.instance.log("Stopping game Error") ;
      FirebaseCrashlytics.instance.recordError(
          e,
          null,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true
      );
    }
    // var newCommand = messageQueueRef.push();
    //
    // newCommand
    //     .set({"CommandeId": "GAME_STOP", "Data": gameData?.toJson()});
  }


  void exitCompetition ({required bool showAlert}) async{

    var exit = showAlert ? await Get.dialog(
      AlertDialogWidget(
          content:
          'You will exit the competition, all the progress will be lost? ',
          actionCancelText: 'Quit',
          actionAcceptText: 'Resume',
          onCancelClicked: () => {
            Get.back(result: true)
          },
          onAcceptClicked: () => {
            Get.back(result: false)
          }),
    ) : true;
    if(exit) {
      Get.rootDelegate.backUntil(Routes.MODE);
      gamesRepository.updateScoreStatus("GAME_STOP",
          StationService.to.gameStatus.value.data["id"]);
    }
  }

  void getLeaderboard() async{
    var scores = await gamesRepository.listScores(_groupCompetition.id.toString(), gameVariant?.game?.data?.attributes?.gamehubId?.toString()??"");
    leaderBoardList.value = scores.leaderBoard! ;
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
