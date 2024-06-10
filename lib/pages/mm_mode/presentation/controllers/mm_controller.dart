import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pleyo_tablet_app/model/strapi/game.dart';
import 'package:pleyo_tablet_app/model/strapi/game_variant.dart';
import 'package:pleyo_tablet_app/model/strapi/multiplayer_game_response.dart';
import 'package:pleyo_tablet_app/model/strapi/videos_api_response.dart';
import 'package:pleyo_tablet_app/pages/mm_mode/data/mm_repository.dart';
import 'package:pleyo_tablet_app/services/InactivityRedirectService.dart';
import 'package:pleyo_tablet_app/services/station_service.dart';
import 'package:pleyo_tablet_app/model/strapi/score_response.dart' as sr;

import '../../../../base/library_item_model.dart';
import '../../../../model/start_game.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/alert.dart';
import '../../../../widgets/alert_dialog.dart';

class MMController extends SuperController<bool> {
  RxBool goPlaying = false.obs;

  var station = StationService.to.currentStation;
  late List<GameVariant> games = station.attributes!.organization!.data!.attributes!.configuration!.data!.attributes!.mmGameVariants!.data!;
  late List<StationVideo> videos = station.attributes!.videos!.data!;

  final IMMRepository mmRepository;
  Rx<GameVariant?> selectedVariant = Rx(null);

  Rx<MultiplayerGame?> multiplayerGame = Rx(null) ;
  Rx<Game?> selectedGame = Rx(null);

  RxBool gameFail = false.obs;
  RxInt gameStatus = 0.obs;
  late StreamSubscription subscription;

  int? selectedDifficulty;


  RxInt dropIndex = (-1).obs ;

  RxList<LibraryItemModel> timelineItems = RxList();

  MMController(
      {required this.mmRepository});

  @override
  void onInit() {
    super.onInit();

    subscription = StationService.to.gameStatus.listen((status) async {
      var newScore = sr.Score(
          id: status.data["id"],
          attributes: sr.Attributes.fromJson(status.data));
      print("---------------------- NEW EVENT --------------------------") ;
      print("${status.type} ${newScore.id} ") ;

      switch (status.type) {
        case GameStatusType.IDLE:
          gameStatus.value = 0;
          break;
        case GameStatusType.UPDATED:
          multiplayerGame.value = MultiplayerGame.fromJson(status.data);
          break;
        case GameStatusType.STARTING:
          gameStatus.value = 1;
          FirebaseCrashlytics.instance.log("game starting");
          break;
        case GameStatusType.STARTED:
        // Get.rootDelegate.backUntil(Routes.SELECT_GAME_DIFFICULTY) ;
          if (selectedVariant.value?.attributes != null) {
            Get.rootDelegate.toNamed(
                "${Routes.MULTIPLAYER_LANDING}/${Routes.MULTIPLAYER_HOST_GAME_PLAY}");
            gameStatus.value = 0;
          }
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
          Get.rootDelegate.backUntil(
              "${Routes.MULTIPLAYER_LANDING}/${Routes.MULTIPLAYER_SELECT_GAME}",
              popMode: PopMode.History);
          break;
      }
    });
  }

  int calculateSessionDuration () {
    if(timelineItems.isEmpty) return 0 ;
    if(timelineItems.length == 1) return timelineItems[0].duration??0 ;
    return timelineItems.map((element) => element.duration??0).reduce((value, element) => value + element,) ;
  }

  String formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final secs = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  Timer? retryTimer ;
  void startGame(int diff) async {
    Get.find<InactivityRedirectService>().userInteracted() ;
    this.selectedDifficulty = diff;
    gameFail.value = false;
    int variant = selectedVariant.value!.id!;
    FirebaseCrashlytics.instance.log("Starting new game v $variant ,d $diff");
    Get.rootDelegate.toNamed(
        "${Routes.MULTIPLAYER_LANDING}/${Routes.MULTIPLAYER_HOST_GAME_STATUS}");
    var now = DateTime.now();
    gameStatus.value = 1;
    await Future.delayed(const Duration(seconds: 1));

    //check available balance
    try {
      //stop game before start new one
      FirebaseCrashlytics.instance.log("Stopping the old game ");
      print("start new game");
      multiplayerGame.value =
      await mmRepository.createMultiplayerGame(
          gameVariant: variant,
          gameDifficulty: diff,
          station: StationService.to.currentStation.id!,
          organization: StationService.to.currentStation.attributes!.organization!.data!.id!,
          nickname: ""
      );
      FirebaseCrashlytics.instance.log("Sending start game success");
      print("Sending start game success ${multiplayerGame.value?.id}");
      retryTimer?.cancel() ;
      retryTimer = Timer(Duration(seconds: 40), () {
        if (gameStatus.value == 1) {
          gameStatus.value = 0;
          gameFail.value = true;
          FirebaseCrashlytics.instance.log("Start game timeout");
        }
      });
    } catch (e , stack) {
      if (e is MapEntry) {
        showAlert("Error", e.value);
      } else {
        showAlert("Error", "Connection error");
      }
      gameStatus.value = 0;
      FirebaseCrashlytics.instance.log("Start game error");
      await FirebaseCrashlytics.instance.recordError(e, stack,
          reason: 'a fatal error',
          // Pass in 'fatal' argument
          fatal: true);
    }
  }

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
      Get.rootDelegate.backUntil(
          "${Routes.MULTIPLAYER_LANDING}/${Routes.MULTIPLAYER_SELECT_GAME}",
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
      Get.rootDelegate.backUntil(
          "${Routes.MULTIPLAYER_LANDING}/${Routes.MULTIPLAYER_SELECT_GAME}",
          popMode: PopMode.History);
    }
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
