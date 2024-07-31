import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:pleyo_tablet_app/model/strapi/join_multiplayer_game_message.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart' as sr;

import '../../../../model/start_game.dart';
import '../../../../model/strapi/multiplayer_game_response.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/alert_dialog.dart';
import '../../data/multiplayer_repository.dart';

class MultiplayerGuestController extends SuperController<bool> {
  int? scoreId = Get.rootDelegate.arguments()["score"] ;
  String? playerName = Get.rootDelegate.arguments()["name"] ;
  Rx<MultiplayerGame?> multiplayerGame = Rx(Get.rootDelegate.arguments()["gameDetails"]) ;


  final IMultiplayerRepository multiplayerRepository;

  RxInt gameStatus = 0.obs;
  late StreamSubscription subscription;

  MultiplayerGuestController(
      {required this.multiplayerRepository});

  @override
  void onInit() {
    super.onInit();
    subscription = StationService.to.gameStatus.listen((status) async {
      var newScore = sr.Score(
          id: status.data["id"],
          attributes: sr.Attributes.fromJson(status.data));
      print("---------------------- NEW EVENT --------------------------") ;
      print("${status.type} ${status.data} ") ;
      if(newScore.id != scoreId) {
        return ;
      }

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
          Get.rootDelegate.toNamed(
              "${Routes.MULTIPLAYER_GUEST_GAME_STATUS}/${Routes.MULTIPLAYER_GUEST_GAME_PLAY}");
          gameStatus.value = 0;
          FirebaseCrashlytics.instance.log("Game started");
          break;
        case GameStatusType.FINISHED:

          //should navigate to game score
          showDialogAfterGameFinished();
          break;
        case GameStatusType.CLOSED:
        case GameStatusType.CRASHED:
          FirebaseCrashlytics.instance
              .log("Game stopped by gamehub durring game starting");
          gameStatus.value = 0;
          print("Back to modes choose another game ") ;
          Get.rootDelegate.backUntil(Routes.MODE,
              popMode: PopMode.History);
          break;
        case GameStatusType.UPDATED:
          multiplayerGame.value = MultiplayerGame.fromJson(status.data);
          break;
        case GameStatusType.PAUSED:
          // TODO: Handle this case.
          break;
        case GameStatusType.RESUMED:
          // TODO: Handle this case.
          break;
      }
    });
  }


  Timer? retryTimer ;

  RxBool createTicketLoading = false.obs;

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
      Get.rootDelegate.backUntil(Routes.MODE,
          popMode: PopMode.History);

      //todo fix
      // multiplayerRepository.updateScoreStatus(
      //     "GAME_STOP", StationService.to.gameStatus.value.data["id"] , reason: reason);

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

    Get.rootDelegate.backUntil(Routes.MODE);

    Future.delayed(const Duration(seconds: 1));
    //todo fix
    // gamesRepository.updateScoreStatus(
    //     "GAME_STOP", StationService.to.gameStatus.value.data["id"] , reason: "Stop game automatically after its finished");
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

  @override
  void onHidden() {
    // TODO: implement onHidden
  }
}
